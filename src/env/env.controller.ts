import { Controller, Put, Param, Get, NotFoundException, Post, Body } from '@nestjs/common';
import { PlainBody } from "src/plain-body.decorator";

@Controller('env')
export class EnvController {
    @Get()
    public getAll(): Record<string, string> {
        return process.env;
    }

    @Get("/:key")
    public getVar(@Param("key") key: string): string {
        const value = process.env[key];
        if (!value) { throw new NotFoundException(); }
        return value;
    }

    @Put("/:key")
    public setVar(
        @Param("key") key: string,
        @PlainBody() value: string
    ): string {
        return process.env[key] = value;
    }
}
