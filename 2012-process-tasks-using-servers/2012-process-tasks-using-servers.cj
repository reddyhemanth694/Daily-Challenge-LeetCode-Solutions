
class MinHeap {
    var a: Array<Int64>
    var size = 0

    init(cap: Int64) {
        a = Array<Int64>(cap, {i => 0})
    }

    func push(v: Int64): Unit {
        a[size] = v
        size++

        var i = size - 1

        while (i > 0) {
            let p = (i - 1) / 2

            if (a[p] <= a[i]) {
                break
            }

            let temp = a[p]
            a[p] = a[i]
            a[i] = temp

            i = p
        }
    }

    func pop(): Int64 {
        let top = a[0]

        size--
        a[0] = a[size]

        var i = 0

        while (true) {
            let l = 2 * i + 1
            let r = l + 1
            var s = i

            if (l < size && a[l] < a[s]) {
                s = l
            }

            if (r < size && a[r] < a[s]) {
                s = r
            }

            if (s == i) {
                break
            }

            let temp = a[s]
            a[s] = a[i]
            a[i] = temp

            i = s
        }

        return top
    }
}

class Solution {
    func assignTasks(servers: Array<Int64>, tasks: Array<Int64>): Array<Int64> {
        let BASE: Int64 = 200001
        let n = servers.size
        let m = tasks.size

        var free = MinHeap(n + 1)
        var busy = MinHeap(n + 1)

        for (i in 0..n) {
            free.push(servers[i] * BASE + i)
        }

        var ans = Array<Int64>(m, {i => 0})
        var clock: Int64 = 0

        for (j in 0..m) {
            var t: Int64 = j

            if (clock > t) {
                t = clock
            }

            while (busy.size > 0 && busy.a[0] / BASE <= t) {
                let k = busy.pop() % BASE
                free.push(servers[k] * BASE + k)
            }

            if (free.size == 0) {
                t = busy.a[0] / BASE
                clock = t

                while (busy.size > 0 && busy.a[0] / BASE <= t) {
                    let k = busy.pop() % BASE
                    free.push(servers[k] * BASE + k)
                }
            }

            let i = free.pop() % BASE

            ans[j] = i

            busy.push((t + tasks[j]) * BASE + i)
        }

        return ans
    }
}
