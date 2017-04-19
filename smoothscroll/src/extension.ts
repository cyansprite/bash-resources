'use strict';
import * as vscode from 'vscode';

export function activate(context: vscode.ExtensionContext) {
    let downDispose = vscode.commands.registerCommand('extension.scrollDown', () => {
        main(0);
    });

    let upDispose = vscode.commands.registerCommand('extension.scrollUp', () => {
        main(1);
    });

    context.subscriptions.push(upDispose);
    context.subscriptions.push(downDispose);
}

async function main(dir) {
    await scroll(dir);
}

async function scroll(dir) {
    var linesToScroll  : number = vscode.workspace.getConfiguration('smoothScroll').get<number>('linesToScroll');
    var totalDelay     : number = vscode.workspace.getConfiguration('smoothScroll').get<number>('totalDelay');
    var calculatedDelay: number = totalDelay / linesToScroll;

    for (var i = 0; i < linesToScroll; i++) {
        if(dir == 0)
        {
            vscode.commands.executeCommand('cursorDown');
            vscode.commands.executeCommand('scrollLineDown');
        }
        else
        {
            vscode.commands.executeCommand('cursorUp');
            vscode.commands.executeCommand('scrollLineUp');
        }
        await delay(calculatedDelay);
    }
}

function delay(ms: number) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

export function deactivate() {
}