# participant = ["leo", "kiki", "eden"]
# completion = ["eden", "kiki"]	

participant = ["mislav", "stanko", "mislav", "ana"]
completion = ["stanko", "ana", "mislav"]

def solution(participant, completion):
    answer = ''
    for i in participant:
        if i in completion:
            completion.remove(i)
        else:
            answer = i
            break
    return answer

print(solution(participant, completion))