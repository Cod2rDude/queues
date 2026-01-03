<h1 id="queues" align="center">queues</h1>
<div align="center">
    <img src="https://img.shields.io/badge/version-1.0.0-orange" alt="Version">
    <br/>
    <a href="https://opensource.org/licenses/MIT">
        <img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License">
    </a>
    <img src="https://img.shields.io/badge/Language-Luau-2C3E50?style=&logo=lua" alt="Luau">
    <img src="https://img.shields.io/badge/Maintained%3F-Sometimes-green.svg" alt="Luau">
</div>
<div align="center">
    Useful queue implementations
</div>

## Table of Contents
- [Table of Contents](#table-of-contents)
- [Why does this even exist?](#why-does-this-even-exist)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
  - [FIFO](#fifo)
  - [Priority Max](#priority-max)
- [API](#api)
  - [FIFO API](#fifo-api)
  - [Priority Max API](#priority-max-api)
- [Found a Bug?](#found-a-bug)
- [Contribution](#contribution)
  - [Contributing](#contributing)
  - [Guidelines](#guidelines)
- [LICENSE](#license)
- [References](#references)

## Why does this even exist?
I needed to use queues while developing some libraries and i was like why dont i make this and put it in github.

## Features
<div>
    In current version (1.0.0) it only features
    <a href="./src/libs/fifo.luau">FIFO</a> 
    and a 
    <a href="./src/libs/priorityMax.luau">priority max</a> 
    queue implementation.
    <br/><br/>
    <div align="center">
        <table width="75%">
        <thead>
            <tr>
                <th align="left">Type</th>
                <th align="left">Enqueue Complexity</th>
                <th align="left">Dequeue Complexity</th>
                <th align="left">Space Complexity</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><b>FIFO Queue</b></td>
                <td><code>O(1)</code></td>
                <td><code>O(1)</code></td>
                <td><code>O(n)</code></td>
            </tr>
            <tr>
                <td><b>Priority Max</b></td>
                <td><code>O(log n)</code></td>
                <td><code>O(log n)</code></td>
                <td><code>O(n)</code></td>
            </tr>
        </tbody>
    </table>
    </div>
</div>

## Installation
To install this to your computer you have this options;

1. Clone this repository by running following command
    ```bash
    git clone https://github.com/Cod2rDude/queues
    ```
2. Get the latest release of .rbxm file from [releases](../../releases)
3. Or add this as a submodule to your project
    ```bash
    git submodule add https://github.com/Cod2rDude/queues [PATH]
    ```
Wally will be added in future.

## Usage
### FIFO
```lua
    local queues = require(path.to.module)

    local size = 10 -- 2 <= size <= 512
    local myFifoQueue = queues.fifo.new(size)

    -- enqueing first item
    myFifoQueue:enqueue(5)
    -- enqueing second item
    myFifoQueue:enqueue(6)

    -- dequeing will return 5 since we added 5 first
    print(myFifoQueue:dequeue()) -- 5
    -- dequeueing again will return 6 because we added 6 after 5
    print(myFifoQueue:dequeue())
```
### Priority Max
```lua
    local queues = require(path.to.module)

    local size = 10 -- 2 <= size <= 512
    local myPriorityQueue = queues.priorityMax.new(size)

    -- object, priority
    myPriorityQueue:enqueue("low", 1)
    myPriorityQueue:enqueue("high", 100)
    myPriorityQueue:enqueue("mid", 50)

    print(myPriorityQueue:dequeue()) -- high
    print(myPriorityQueue:dequeue()) -- mid
    print(myPriorityQueue:dequeue()) -- low
```

## API
Please check out source code for further info about api.

### FIFO API
<div align="center">
    <table width="75%">
        <thead>
            <tr>
                <th align="left">Function</th>
                <th align="left">Parameters</th>
                <th align="left">Returns</th>
                <th align="left">Description</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><code>.new()</code></td>
                <td>
                    <ol>
                        <li>
                            <span>@param: <code>maxItems</code></span>
                            <br/><span>@type: <code>number</code></span>
                            <br/><span>@brief: Size of queue</span>
                        </li>
                    </ol>
                </td>
                <td>
                    <ol>
                        <li>
                            <span>@type: <code>fifo_queue</code></span>
                            <br/><span>@brief: New fifo queue object.</span>
                        </li>
                    </ol>
                </td>
                <td>Creates a new fifo queue object.</td>
            </tr>
            <tr>
                <td><code>:size()</code></td>
                <td></td>
                <td>
                    <ol>
                        <li>
                            <span>@type: <code>number</code></span>
                            <br/><span>@brief: Current size of queue.</span>
                        </li>
                    </ol>
                </td>
                <td>Returns the current size of queue.</td>
            </tr>
            <tr>
                <td><code>:isEmpty()</code></td>
                <td></td>
                <td>
                    <ol>
                        <li>
                            <span>@type: <code>boolean</code></span>
                            <br/><span>@brief: Returns true if queue is empty.</span>
                        </li>
                    </ol>
                </td>
                <td>Returns currentSize == 0.</td>
            </tr>
            <tr>
                <td><code>:isFull()</code></td>
                <td></td>
                <td>
                    <ol>
                        <li>
                            <span>@type: <code>boolean</code></span>
                            <br/><span>@brief: Returns true if queue is full.</span>
                        </li>
                    </ol>
                </td>
                <td>Returns currentSize == maxSize.</td>
            </tr>
            <tr>
                <td><code>:peek()</code></td>
                <td></td>
                <td>
                    <ol>
                        <li>
                            <span>@type: <code>any</code></span>
                            <br/><span>@brief: Object at the head of queue..</span>
                        </li>
                    </ol>
                </td>
                <td>Returns the object at the head of queue without removing it.</td>
            </tr>
            <tr>
                <td><code>:enqueue()</code></td>
                <td>
                    <ol>
                        <li>
                            <span>@type: <code>any</code></span>
                            <br/><span>@brief: Object to add to queue.</span>
                        </li>
                    </ol>
                </td>
                <td></td>
                <td>Puts a new object at the queue's tail.</td>
            </tr>
            <tr>
                <td><code>:dequeue()</code></td>
                <td></td>
                <td>
                    <ol>
                        <li>
                            <span>@type: <code>any</code></span>
                            <br/><span>@brief: Removed object from queue's head.</span>
                        </li>
                    </ol>
                </td>
                <td>Removes and returns the object at the head of queue.</td>
            </tr>
            <tr>
                <td><code>:clean()</code></td>
                <td></td>
                <td></td>
                <td>Clears the queue (resets).</td>
            </tr>
        </tbody>
    </table>
</div>

### Priority Max API
<div align="center">
    <table width="75%">
        <thead>
            <tr>
                <th align="left">Function</th>
                <th align="left">Parameters</th>
                <th align="left">Returns</th>
                <th align="left">Description</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><code>.new()</code></td>
                <td>
                    <ol>
                        <li>
                            <span>@param: <code>maxItems</code></span>
                            <br/><span>@type: <code>number</code></span>
                            <br/><span>@brief: Size of queue</span>
                        </li>
                    </ol>
                </td>
                <td>
                    <ol>
                        <li>
                            <span>@type: <code>priorityMax_queue</code></span>
                            <br/><span>@brief: New priority max queue object.</span>
                        </li>
                    </ol>
                </td>
                <td>Creates a new priority max queue object.</td>
            </tr>
            <tr>
                <td><code>:size()</code></td>
                <td></td>
                <td>
                    <ol>
                        <li>
                            <span>@type: <code>number</code></span>
                            <br/><span>@brief: Current size of queue.</span>
                        </li>
                    </ol>
                </td>
                <td>Returns the current size of queue.</td>
            </tr>
            <tr>
                <td><code>:isEmpty()</code></td>
                <td></td>
                <td>
                    <ol>
                        <li>
                            <span>@type: <code>boolean</code></span>
                            <br/><span>@brief: Returns true if queue is empty.</span>
                        </li>
                    </ol>
                </td>
                <td>Returns currentSize == 0.</td>
            </tr>
            <tr>
                <td><code>:isFull()</code></td>
                <td></td>
                <td>
                    <ol>
                        <li>
                            <span>@type: <code>boolean</code></span>
                            <br/><span>@brief: Returns true if queue is full.</span>
                        </li>
                    </ol>
                </td>
                <td>Returns currentSize == maxSize.</td>
            </tr>
            <tr>
                <td><code>:peek()</code></td>
                <td></td>
                <td>
                    <ol>
                        <li>
                            <span>@type: <code>any</code></span>
                            <br/><span>@brief: Object with highest priority in queue..</span>
                        </li>
                    </ol>
                </td>
                <td>Returns the object with highest priority in queue without removing it.</td>
            </tr>
            <tr>
                <td><code>:enqueue()</code></td>
                <td>
                    <ol>
                        <li>
                            <span>@type: <code>any</code></span>
                            <br/><span>@brief: Object to add to queue.</span>
                        </li>
                        <li>
                            <span>@type: <code>number</code></span>
                            <br/><span>@brief: Priority of object.</span>
                        </li>
                    </ol>
                </td>
                <td></td>
                <td>Puts a new object at the queue.</td>
            </tr>
            <tr>
                <td><code>:dequeue()</code></td>
                <td></td>
                <td>
                    <ol>
                        <li>
                            <span>@type: <code>any</code></span>
                            <br/><span>@brief: Removed object from queue with highest priority.</span>
                        </li>
                    </ol>
                </td>
                <td>Removes and returns the object with highest priority in queue.</td>
            </tr>
            <tr>
                <td><code>:clean()</code></td>
                <td></td>
                <td></td>
                <td>Clears the queue (resets).</td>
            </tr>
        </tbody>
    </table>
</div>

## Found a Bug?
If you encounter any issues or unexpected behavior, please let me know! Your feedback helps make this library more stable.

1. Check the [existing issues](../../issues) to see if it has already been reported.
2. If not, open a [new issue](../../issues/new) and describe the problem.
3. Provide a small code snippet to reproduce the bug if possible.

## Contribution
Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

### Contributing
To maintain the stability of the library, **direct commits to the main branch are restricted.** Please follow the workflow below to suggest changes:

1.  **Fork the Project:** Create your own copy of this repository.
2.  **Create a Feature Branch:**
    ```bash
    git checkout -b feature/AmazingFeature
    ```
3.  **Commit your changes:**
    ```bash
    git commit -m 'Add some AmazingFeature'
    ```
4.  **Push to branch:**
    ```bash
    git push origin feature/AmazingFeature
    ```
5.  **Open a Pull Request:** Navigate to the original repository and click "New Pull Request". Describe your changes in detail so they can be reviewed.

Once your Pull Request is merged, GitHub will automatically list you in the official "Contributors" section of the repository. (i guess so)

After a successful merge, I will also manually add your name and contribution to the table below!

### Guidelines
We appreciate contributions you will make but we will also highly appreciate you to follow our guidelines while contributing.

1.  Of course make sure your code is efficient.
2.  No nsfw links, swearing or anything like those.
3.  Maybe follow the coding style we do.
4.  That's it!

<div id="contributors">
    <h2>Contributors</h2>
    <div align="center">
        <table width="75%">
            <thead>
                <tr>
                    <th align="left">Contributor</th>
                    <th align="left">Description</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><b><a href="https://github.com/Cod2rDude">Cod2rDude</a></b></td>
                    <td>Creator</td>
                </tr>
                <tr>
                    <td><b><a href="https://github.com/scrpt2r">scrpt2r</a></b></td>
                    <td>Helped on __log__</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

## [LICENSE](./LICENSE)
This project is licensed under [The MIT License](https://opensource.org/license/mit)

## References
* **Big-O Cheatsheet** (n.d.) *Know Thy Complexities!* Retrieved from https://www.bigocheatsheet.com/
* **Wikipedia contributors.** (2024, November 20). *Big O notation.* In Wikipedia, The Free Encyclopedia. Retrieved from https://en.wikipedia.org/wiki/Big_O_notation
* **Wikipedia contributors.** (2024, November 25). *Circular buffer.* In Wikipedia, The Free Encyclopedia. Retrieved from https://en.wikipedia.org/wiki/Circular_buffer
* **Wikipedia contributors.** (2024, December 1). *FIFO (computing and electronics).* In Wikipedia, The Free Encyclopedia. Retrieved from https://en.wikipedia.org/wiki/FIFO_(computing_and_electronics)
* **Wikipedia contributors.** (2024, December 15). *Heap (data structure).* In Wikipedia, The Free Encyclopedia. Retrieved from https://en.wikipedia.org/wiki/Heap_(data_structure)

<div align="right">
    <a href="#queues">
        <img src="https://img.shields.io/badge/TOP-↑-blue?style=flat-square" alt="Back to Top">
    </a>
</div>