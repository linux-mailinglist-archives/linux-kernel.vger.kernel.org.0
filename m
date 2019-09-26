Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C325BFA58
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2019 21:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfIZT60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Sep 2019 15:58:26 -0400
Received: from mail-yw1-f48.google.com ([209.85.161.48]:38262 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbfIZT60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:58:26 -0400
Received: by mail-yw1-f48.google.com with SMTP id s6so125596ywe.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 12:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=YyliMHGG5rAVG/6KnCo18E73UZJckVpzMI6irjvW1cc=;
        b=EhFm551QCGIVL288tfEzmv8Z8VFkUfyi7NwDIAcXZYnZFQSCAupNIfzwk3sCImAIu7
         pMqEJiQr8LLVdmVTzyCfxqPRknhab7FQXBn/YcnOcexWEU/Y5lGqM69own/+s7hfsGBG
         biIVn7xn2o71jdBquV/hE7dmfunp0m17Gc5VwxOxMLu+9G56A+RkBlZRnk8UpZSVbDB/
         1Zc5WPRQoxv91gvKNrm0Q8uNDLNw1C5e5HzsGziGxsBAUyMUxfbgaI0HPHrVokgsnotO
         zgqcA+1iR1igT3pZWDuHu79YHjNXyccQ2L1pqVSA1GtKk+hfLkC0oUsxSnmGBgf9ps26
         vqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YyliMHGG5rAVG/6KnCo18E73UZJckVpzMI6irjvW1cc=;
        b=ryRcrk6jPRCobPwkSMyXJRb/o0zTX/qdaHN0QryXpxQyxZgbU7SXk3F+wf7LoRrgiq
         flRLRnRZR7k4p7S05PUw3BlU0OXCKk8gHIIEModG8B8IEBrvy6tOGkxL1w5G7qbJpc2+
         w7mc+685fxYqPpzOGg+dxMp8MOy9cj0Mi9GmSXoIMWWWjicqS1Z6at9GPi/BUoGOoM5K
         p0sn27znfRWQQVx4vzI5OHwgJG+9B9exKn9EwqzBfmlcnPGs92Qnz6itpf8tcsorLFs4
         SfII1lHsHGwLUqL7Xc5i5Bbhab3llwhtodjU5R6EqzhWmKPacNJmP49GGqarL9MwBPTM
         0YGg==
X-Gm-Message-State: APjAAAVwIMf96NwE/b2f3VjwdpsmmBtRhQvUf4EoVlkfTOWqF2nAf4aP
        2faiaOWD6mZr8GFyCbDRm7no8wNcKHLpeaAormUpHVHW
X-Google-Smtp-Source: APXvYqziR2V+wD0Lsq9Q7MxDyIQHZCwNAeFQ+JcoAZf6PcPwS+YrMV0OkPOuwZEUQ6EVZ0v61pDjeXSkI9bsgXnoQII=
X-Received: by 2002:a0d:d9d3:: with SMTP id b202mr133589ywe.63.1569527904060;
 Thu, 26 Sep 2019 12:58:24 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Date:   Thu, 26 Sep 2019 15:57:58 -0400
Message-ID: <CAD-N9QWFisTLhw4afMZDdhAkLcb32MAWdvXKJ=YZwKroxhFt0g@mail.gmail.com>
Subject: Summary of Crash/Panic Behaviors in Linux Kernel
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

Is there any summary of crash/panic behaviors in the Linux Kernel? For
example, GPF (general protection fault), Kernel BUG (BUG_ON).

--
My best regards to you.

     No System Is Safe!
     Dongliang Mu
