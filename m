Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90AE824EA0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 14:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfEUMG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 08:06:28 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45683 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEUMG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:06:28 -0400
Received: by mail-qk1-f195.google.com with SMTP id j1so10812796qkk.12;
        Tue, 21 May 2019 05:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SVsTcwbSXyDKa9FaSATioyfgfATBsO2UVB5hXgNRDGU=;
        b=slSOW8WFtgJXTulJi6E1AkNyJ/4SyEHSQfXWnNGBoKOYazzkeYzwU6/D2SyPATjv/a
         i//KYH7XMHm0IHu6UQuc50GBAlX0d0kqLekDtJvvb35QrXtq9Kj6d5n64mVm9JXAMz4e
         qRqqvmT9xnU6QfJ3oKxewV72hi2qyV7nbg0ao2YnivIEM0gmY24dgLZBhINcJpnoSc2r
         1RxXa5q/cqPKt2sR6m+r26HMZv0tSWZjt1zRmmwkYSzxWW6dPIFd//l6ZhCmx5KPqtO7
         STTD8Ar8l0mI8TkfqTROktyGGCLbFDa+tQlhYNGmUBE+t8jRPTG48V0jOu2a8Mx88nWL
         cLiA==
X-Gm-Message-State: APjAAAUGVa9p1tTzyqefV7tJZAVL/AsFw39iGELVCYE5fENBanNgXnPp
        Q3wBZrqjNjqr7mAQkaqxKLpOwRJyMkO+d5VsFtM=
X-Google-Smtp-Source: APXvYqwtbMXWbcpZkpurvbTnz8ZSYDkvuMAiZAitynBUdC5HgLlJCLa614LeBCFxuz8JnW/vd1HtztDq3B07yoz2uQw=
X-Received: by 2002:a05:620a:1085:: with SMTP id g5mr46716572qkk.182.1558440387587;
 Tue, 21 May 2019 05:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <1558383565-11821-1-git-send-email-eajames@linux.ibm.com> <1558383565-11821-5-git-send-email-eajames@linux.ibm.com>
In-Reply-To: <1558383565-11821-5-git-send-email-eajames@linux.ibm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 May 2019 14:06:10 +0200
Message-ID: <CAK8P3a1DxtZFtgHbM7RmcadvRd8ZzjYXjR41OxhDkiKg55CTMQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] drivers/soc: xdma: Add PCI device configuration sysfs
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 10:21 PM Eddie James <eajames@linux.ibm.com> wrote:
>
> The AST2500 has two PCI devices embedded. The XDMA engine can use either
> device to perform DMA transfers. Users need the capability to choose
> which device to use. This commit therefore adds two sysfs files that
> toggle the AST2500 and XDMA engine between the two PCI devices.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/soc/aspeed/aspeed-xdma.c | 64 ++++++++++++++++++++++++++++++++++++++++

This patch needs to come with a corresponding file in Documentation/ABI/

       Arnd
