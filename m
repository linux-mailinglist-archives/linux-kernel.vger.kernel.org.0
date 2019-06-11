Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40C383DBB7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 22:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406467AbfFKUQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 16:16:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39679 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406133AbfFKUQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 16:16:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so11782597wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 13:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rdnkv68QQM90C5QWNTYgPjC6Dj76JDdVz07nlfyP5ZQ=;
        b=hQQshxw4L8UXE+gz40O8iQyiPXXifPlINYxKfWzOe8AeWC02uo7i7QWZ39sq37D8ox
         DDFyHZaImSkOCvk42zIhCjfsfF1n74QVSxkBNuxgqHGbaGYMsME3e21yDuAdX/vkVLHS
         g3/R/MWsmyTknKHVPTLQYwK0loQOj1jSvH9d8Zgsf8EiFfh+QzFk37z1/yOXMWVPWKNa
         PXgFoQNEEdTSQDcyqlaAh9+PyExrNFRcCFAIHuX7g5cma0yDci3SRryO2Kk9qOuFOmbb
         pyC9s8iPb+GfljNG+GTpKBoNBxhPoz/UdJs7sHGl/0MG1pewPhj1HKtwTf8tCbqid4vG
         ntGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rdnkv68QQM90C5QWNTYgPjC6Dj76JDdVz07nlfyP5ZQ=;
        b=XgmhkLDjMO+NMOd6fHMUlSIdf4ipd2ZWMRjQrhybe5XHQXV1bj8NtWl4SNxkWxQOwv
         dItgcTWRm27JiV8lGhifNbZH+HHb4DGJTo1pZyAyHBpYf6//JkrcR8X7bNUpBEodXlS6
         5XoKauf3GESbwCHsZfRwTQW+22er3WAF/R8o9TVHTjRCTbawNSEgfrjAx6HPD2EZcMOH
         UCGhe7ATuJxa5ijpBx/6tv6g392pNwO39UDQd79Zd3tZPesFjm5mFejcHSksArB916Zx
         sP0jSBgM67EbbJsC95bT79rXFQIQd1bclbOx54Hi2a+ZaNK7JkV4JzJUwbYzKklUsC/m
         u2Pg==
X-Gm-Message-State: APjAAAVAiHvUSQd6Oq/3hwz8t80QbALMbSM4qfBg4Ix4jhVqUcjf5nn5
        oalmY6OUnkE+OIZxT/Np/OhLfDy+aU67UEMp7XE=
X-Google-Smtp-Source: APXvYqw9zQWawZNBHmOZsCkDsL6jKqCMRayKffZHiF0OiFQ6eYUoHK9eVpmVK9vgG42NhaHXEfAmRCbZ+FTcS1ZnoHQ=
X-Received: by 2002:adf:f14a:: with SMTP id y10mr37882612wro.183.1560284208310;
 Tue, 11 Jun 2019 13:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <1558024913-26502-1-git-send-email-kdasu.kdev@gmail.com>
 <1558024913-26502-2-git-send-email-kdasu.kdev@gmail.com> <CAFLxGvyZCpKthJevFHjjBQXo=j5f-FUip0MAsLy0HaoJzLZ2rA@mail.gmail.com>
 <CAC=U0a2UxMG2SuVCjv=TLzMs7Dg3yqJdxW6ft2tSQgEKj0C6ZQ@mail.gmail.com> <CAC=U0a3co4Ju94pEp4exDYNz=G7YnEztjdZWSjOBKTL+C_7g8Q@mail.gmail.com>
In-Reply-To: <CAC=U0a3co4Ju94pEp4exDYNz=G7YnEztjdZWSjOBKTL+C_7g8Q@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 11 Jun 2019 22:16:36 +0200
Message-ID: <CAFLxGvzMhDwoP5wqLFq-SUyDsyPNCMmiNgSr=FXFL6ee1uA4dw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mtd: nand: raw: brcmnand: When oops in progress
 use pio and interrupt polling
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     MTD Maling List <linux-mtd@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
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

On Tue, Jun 11, 2019 at 10:03 PM Kamal Dasu <kdasu.kdev@gmail.com> wrote:
>
> Richard,
>
> You have any other review comments/concerns with this patch, if not
> can you please sign off on it.

I'm fine with that approach.
I hoped to get some input from other MTD folks too :-(

-- 
Thanks,
//richard
