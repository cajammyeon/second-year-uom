#!/usr/bin/env python3
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""Sample code for Comp24011 Constraints lab solution

NB: The default code in non-functional; it simply avoids type errors
"""

__author__ = "s61110ab"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

import constraint
import sys

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

def Travellers(axiomList, extraPairs):
    """Solves Task 1 of the lab manual

    :param axiomList: list of puzzle axioms
    :type axiomList:  list[int]
    :param extraPairs: list of (traveller,destination) pairs
    :type extraPairs:  list[tuple[str,str]]

    :return: list of solutions
    :rtype:  list[dict[str,str]]
    """
    problem = constraint.Problem()

    people = ['claude', 'olga', 'pablo', 'scott']
    times = ['2:30', '3:30', '4:30', '5:30']
    destinations = ['peru', 'romania', 'taiwan', 'yemen']

    t_variables = list(map(( lambda x: 't_' + x ), people))
    d_variables = list(map(( lambda x: 'd_' + x ), people))

    problem.addVariables(t_variables, times)
    problem.addVariables(d_variables, destinations)

    problem.addConstraint(constraint.AllDifferentConstraint(), t_variables)
    problem.addConstraint(constraint.AllDifferentConstraint(), d_variables)

    # handle extra pairs
    for pair in extraPairs :
      print(pair)
      if (pair[1] == 'yemen' or pair[1] == 'taiwan' or pair[1] == 'romania' or pair[1] == 'peru') :
        problem.addConstraint(
          (
            lambda x:
              (x == pair[1])
          ), ['d_' + pair[0]]
        )
      else :
        problem.addConstraint(
          (
            lambda x:
              (x == pair[1])
          ), ['t_' + pair[0]]
        )

    # for first constraint : Olga is leaving 2 hours before the traveller from Yemen
    if (1 in axiomList) :
      for person in people :
        problem.addConstraint(
          (
            lambda x, y, z:
              (y != 'yemen')
              or ((x == '4:30') and (z == '2:30'))
              or ((x == '5:30') and (z == '3:30'))
          ), ['t_'+ person, 'd_' + person, 't_olga']
        )

    # for second constraint : Claude is either the person leaving at 2:30 or traveller leaving at 3:30
    if (2 in axiomList) :
      problem.addConstraint(
        (
          lambda x:
            (x == '2:30') or (x == '3:30')
        ), ['t_claude']
      )  

    # for third constraint : the person leaving at 2:30 pm is flying from Peru
    if (3 in axiomList) :
      for person in people :
        problem.addConstraint(
          (
            lambda x, y:
              (x != '2:30') 
              or (y == 'peru')
          ), ['t_' + person, 'd_' + person]
        )

    # for fourth constraint : the person flying from Yemen is leaving earlier than the person flying from Taiwan
    if (4 in axiomList) :
      for person1 in people :
        for person2 in people :
          if (person1 == person2) : continue
          problem.addConstraint(
            (
              lambda w, x, y, z:
                (x != 'yemen' or z != 'taiwan')
                or (w == '2:30' and ((y == '3:30') or (y == '4:30') or (y == '5:30')))
                or (w == '3:30' and ((y == '4:30') or (y == '5:30')))
                or (w == '4:30' and (y == '5:30'))
            ), ['t_' + person1, 'd_' + person1, 't_' + person2, 'd_' + person2]
          )

    # for fifth constraint : Pablo, people leaving at 2:30, 3:30 and yemen are different person
    if (5 in axiomList) :
      # Pablo cannot travel to yemen, cannot leave at 2:30 and 3:30
      problem.addConstraint(
        (
          lambda x, y:
            ((x == '4:30') or (x == '5:30')) and (y != 'yemen')
        ), ['t_pablo', 'd_pablo']
      )

      # People flying from yemen cannot leave at 2:30 and 5:30
      for person in people :
        problem.addConstraint(
          (
            lambda x, y:
              (x != 'yemen')
              or ((x == 'yemen') and (y == '4:30'))
              or ((x == 'yemen') and (y == '5:30'))
          ), ['d_' + person, 't_' + person]
        )

    return problem.getSolutions()


def CommonSum(n):
  """Solves Task 2 of the lab manual

  :param n: size of square
  :type n:  int

  :return: common sum
  :rtype:  int
  """

  max_value = (n ** 2)
  total_square = (max_value * (max_value + 1)) / 2
  common_sum = total_square / n
  return common_sum


def BrokenDiags(n):
  """Solves Task 3 of the lab manual

  :param n: size of square
  :type n:  int

  :return: list of broken diagonals
  :rtype:  list[list[int]]
  """

  return_list = []

  """ Solving the forward diagonals """

  # check forward edges of the square
  forward_edge = []

  for i in range(n + 1) :
    if i == 0 : continue
    else :
      forward_edge.append(n * i - 1)

  # compute the forward diagonals
  for j in range(n) :
    temp_list = []
    m_prev = j

    for i in range(n) :
      if i == 0 : temp_list.append(m_prev)
      else :
        m_new = m_prev + n + 1
        if m_new > forward_edge[i] : m_new = m_prev + 1
        temp_list.append(m_new)
        m_prev = m_new

    return_list.append(temp_list)

  """ Solving the backward diagonals """

  for j in range(n) :
    temp_list = []
    m_prev = j

    for i in range(n) :
      if i == 0 : temp_list.append(m_prev)
      else :
        m_new = m_prev + n - 1
        if m_new == forward_edge[i - 1] : m_new = forward_edge[i]
        temp_list.append(m_new)
        m_prev = m_new

    return_list.append(temp_list)

  return return_list

def MSquares(n, axiomList, extraPairs):
  """Solves Task 4 of the lab manual

  :param n: size of square
  :type n:  int
  :param axiomList: list of magic square axioms
  :type axiomList:  list[int]
  :param extraPairs: list of (position,value) pairs
  :type extraPairs:  list[tuple[int,int]]

  :return: list of solutions
  :rtype:  list[dict[int,int]]
  """

  problem = constraint.Problem()

  common_sum = int(CommonSum(n))

  problem.addVariables(range(0, n ** 2), range(1, (n ** 2) + 1))
  problem.addConstraint(constraint.AllDifferentConstraint(), range(0, n ** 2))

  # solving extra pairs
  for pair in extraPairs :
    problem.addConstraint(constraint.ExactSumConstraint(pair[1]), [pair[0]])

  # first constraint : sum of each row is the common sum for a magic square of size n
  if (1 in axiomList) :
    j = 0

    while (j < n * n) :
      temp_mat = []
      for i in range(n) :
          temp_mat.append(i + j)

      problem.addConstraint(constraint.ExactSumConstraint(common_sum), temp_mat)

      j += n

  # second constraint : sum of each column is the common sum for a magic square of size n
  if (2 in axiomList) :
    for i in range(n) :
      temp_mat = []
      
      for j in range(n) :
        temp_mat.append(i + (n * j))

      problem.addConstraint(constraint.ExactSumConstraint(common_sum), temp_mat)

  # third constraint : sum of each main diagonal is the common sum for a magic square of size n
  if (3 in axiomList) :
    for i in [0, n - 1] :
      temp_mat = []
    
      if (i == 0) :
        for j in range(n) :
          temp_mat.append(i + j * (n + 1))
      else :
        for j in range(n) :
          temp_mat.append(i + j * (n - 1))

      problem.addConstraint(constraint.ExactSumConstraint(common_sum), temp_mat)

  # fourth constraint : the sum of each broken diagonal is the common sum for a magic square of size n
  if (4 in axiomList) :
    broken_diags = BrokenDiags(n)

    for broken in broken_diags :
      problem.addConstraint(constraint.ExactSumConstraint(common_sum), broken)

  return problem.getSolutions()

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# debug run
if __name__ == '__main__':
  if len(sys.argv) > 2:
    cmd = "{}({})".format(sys.argv[1], ",".join(sys.argv[2:]))
    print("debug run:", cmd)
    ret = eval(cmd)
    print("ret value:", ret)
    try:
      cnt = len(ret)
      print("ret count:", cnt)
    except TypeError:
      pass
  else:
    sys.stderr.write("Usage: {} <FUNCTION> <ARG>...\n".format(sys.argv[0]))
    sys.exit(1)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# vim:set et ts=2 sw=2:
