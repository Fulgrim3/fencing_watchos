/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The structure that returns cycling, golf, and running workout compositions.
*/

import HealthKit
import WorkoutKit

struct WorkoutStore {
    static func createCyclingCustomWorkout() -> CustomWorkout {
        // Warmup step
        let warmupStep = WorkoutStep()
        
        // Block 1.
        let block1 = Self.cyclingBlockOne()
        
        // Block 2.
        let block2 = Self.cyclingBlockTwo()

        // Cooldown.
        let cooldownStep = WorkoutStep(goal: .time(5, .minutes))
        
        return CustomWorkout(activity: .cycling,
                             location: .outdoor,
                             displayName: "My Workout",
                             warmup: warmupStep,
                             blocks: [block1, block2],
                             cooldown: cooldownStep)
    }
    
    static func cyclingBlockOne() -> IntervalBlock {
        // Work step 1.
        var workStep1 = IntervalStep(.work)
        workStep1.step.goal = .distance(2, .miles)
        workStep1.step.alert = .speed(10, unit: .milesPerHour, metric: .current)

        // Recovery step.
        var recoveryStep1 = IntervalStep(.recovery)
        recoveryStep1.step.goal = .distance(0.5, .miles)
        recoveryStep1.step.alert = .heartRate(zone: 1)
        
        return IntervalBlock(steps: [workStep1, recoveryStep1],
                             iterations: 4)
    }
    
    static func cyclingBlockTwo() -> IntervalBlock {
        // Work step.
        var workStep2 = IntervalStep(.work)
        workStep2.step.goal = .time(2, .minutes)
        workStep2.step.alert = .power(250...275, unit: .watts)

        // Recovery step.
        var recoveryStep2 = IntervalStep(.recovery)
        recoveryStep2.step.goal = .time(30, .seconds)
        recoveryStep2.step.alert = .heartRate(zone: 1)
        
        // Block with two iterations.
        return IntervalBlock(steps: [workStep2, recoveryStep2],
                             iterations: 2)
    }
    
    static func createFencingWorkout() -> SingleGoalWorkout {
        SingleGoalWorkout(activity: .fencing,
                          goal: .time(15, .minutes))
    }
    
    static func createRunningCustomWorkout() -> CustomWorkout {
        let warmupStep = WorkoutStep(goal: .time(10, .minutes))
        let cooldownStep = WorkoutStep(goal: .time(10, .minutes))
        
        var recoveryStep = IntervalStep(.recovery)
        recoveryStep.step.goal = .distance(2, .miles)
        recoveryStep.step.alert = .speed(10...12, unit: .milesPerHour, metric: .current)
        
        var tempoStep = IntervalStep(.work)
        tempoStep.step.goal = .distance(3, .miles)
        tempoStep.step.alert = .speed(10...15, unit: .milesPerHour, metric: .current)
        
        var block = IntervalBlock()
        
        block.steps = [
            recoveryStep,
            tempoStep,
            tempoStep,
            recoveryStep
        ]
        block.iterations = 4
        
        return CustomWorkout(activity: .running,
                             location: .outdoor,
                             displayName: "New Running Workout",
                             warmup: warmupStep,
                             blocks: [block],
                             cooldown: cooldownStep)
    }
}

