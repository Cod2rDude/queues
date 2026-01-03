<h1 align="center">queues</h1>
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
    Useful queue implomentations
</div>

## Why does this even exist?
I needed to use queues while developing some libraries and i was like why dont i make this and put it in github.

<div>
    <h2>Features</h2>
    In current version (1.0.0) it only features
    <a href="./src/libs/fifo.luau">FIFO</a> 
    and a 
    <a href="./src/libs/priorityMax.luau">priority max</a> 
    queue implementation.
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

<div>
    <h2>Installation</h2>
    To install this to your computer you have this options;
    <br/><br/>
    <div align="left">
        <ol>
            <li>
                Clone this repository by running following command,<br/>
                <div style="background: #1e1e1e; padding: 5px; border-radius: 5px; font-family: monospace;">
                    <span style="color: #dcdcaa;">git</span>
                    <span style="color: #c2b9b6ff;">clone https://github.com/Cod2rDude</span>
                </div>
            </li>
            <li>
                Get the latest release of .rbxm file from
                <a>releases.</a>
            </li>
            <li>
                Or add this as a submodule to your project.
                <div style="background: #1e1e1e; padding: 5px; border-radius: 5px; font-family: monospace;">
                    <span style="color: #dcdcaa;">git</span>
                    <span style="color: #c2b9b6ff;">submodule add https://github.com/Cod2rDude</span>
                    <span style="color: #30cf38ff;">[PATH]</span>
                </div>
            </li>
        </ol>
        <h5>Wally will be added in future.</h5>
    </div>
</div>

<div>
    <h2>Usage</h2>

</div>

<div>
    <h2>API Reference</h2>
</div>

<div>
    <h2>Contributing</h2>
    <div>
    </div>
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
    <h2><a href="./LICENSE">LICENSE</a></h2>
</div>

<div>
    <h2>References</h2>

</div>

###### i used ai while making readme 🤭
