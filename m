Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAACE150D5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 18:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfEFQB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 12:01:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51683 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfEFQBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:01:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id o189so5514600wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 09:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fq6Rg4IrSXPz0SMvZAQc0O8wglN6Db1bmZTbJ+slX3E=;
        b=RFjOeO/I5XhStfzmJFQYBRPDHZUykmUhET0RReJNY4I9bRGCiDw4lSDInj2U38cEzk
         7YGN88N9V+gxpa9w7vcmHKrMfiFns6uWgE87rU146nYYorCDyP7XgPszmYLCvtH7ExD0
         XHmjaJIMcfCcRajHst6iDgbtlByFQwZFpt2kWidfbFYFhOLGseFoykmBhDxSqfabZmlz
         1InpFXE+7EFtU4WWDTpA4u87IJo4ThNDSZEvCKVWIFNGBorfqHx0y/LruXmsCVq7mx37
         HApyk05SuYYF/MmTjZ2OekM06PnohPQgGbzvQyB29pQAWosqfHFFzUco3NEfoU1xpiYc
         vDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fq6Rg4IrSXPz0SMvZAQc0O8wglN6Db1bmZTbJ+slX3E=;
        b=ckyFheLmmJrr357KNqC0CzbGPt5nTNW5HB3DLFbyftfy+davO+zgwNJ8WeSj9K/wrU
         R6u0v4AiFLCarh/4/Jzep+cVJdqxBBSPG6vAe/iXIZebkYBlYCPTDasGGjAzi4lSUqZP
         EExW8Wy1VIY0lhlCDGOqVrZnrq7ZnnthRcCHCYcfZHweafp4zyjwnI6aKe7U8R4cIC9X
         VqUqSa2uWnqVSxLngRftQOFfiEkBS4gjJMWrUH7hxajUFZSwWJF9VejSDTNgGQ7XHSUb
         gocV5oJzslYWy+uvkXcMGINVdaomR7B0GfINd46oxsxZXrljfacmwcKcZX8GCJMlaT/+
         LGYQ==
X-Gm-Message-State: APjAAAXxmCFoDERVxWP9nnZE1BYuFEgy9NK8rOwVdgZmCHuM6Kt84hqL
        mOXnwyy2fbqcar9PSOiaT/12GVMZv5jWPomQGH0=
X-Google-Smtp-Source: APXvYqwvZx2zTdRL4V8WUBMU7IKcJzlOh/R1MWEl5ktXcx9mgfuI5rurp9Bxvg3iiCgsZSJ1ro+tEr3Jdk9c56Mt0y4=
X-Received: by 2002:a7b:c00e:: with SMTP id c14mr16725128wmb.110.1557158483845;
 Mon, 06 May 2019 09:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <1556733121-20133-1-git-send-email-kdasu.kdev@gmail.com>
In-Reply-To: <1556733121-20133-1-git-send-email-kdasu.kdev@gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 6 May 2019 18:01:11 +0200
Message-ID: <CAFLxGvy7B2K2AX0nSe549QF-gDMZcc5F4X0Y+yzRrnYfL9svEw@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: raw: brcmnand: When oops in progress use pio
 and interrupt polling
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        LKML <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 7:52 PM Kamal Dasu <kdasu.kdev@gmail.com> wrote:
>
> If mtd_oops is in progress switch to polling for nand command completion
> interrupts and use PIO mode wihtout DMA so that the mtd_oops buffer can
> be completely written in the assinged nand partition. This is needed in
> cases where the panic does not happen on cpu0 and there is only one online
> CPU and the panic is not on cpu0.

This optimization is highly specific to your hardware and AFAIK cannot
be applied
in general to brcmnand.

So the problem you see is that depending on the oops you can no longer use dma
or interrupts in the driver?

How about adding a new flag to panic_nand_write() which tells the nand
driver that
this is a panic write?
That way you can fall back to pio and polling mode without checking cpu numbers
and oops_in_progress.

-- 
Thanks,
//richard
