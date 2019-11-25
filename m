Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A936F108CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 12:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfKYLP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 06:15:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37024 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfKYLP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:15:27 -0500
Received: by mail-pf1-f195.google.com with SMTP id p24so7223871pfn.4;
        Mon, 25 Nov 2019 03:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=70lfioNuAj/Ldn/hkMoS28PuEmF1/cpUW0s4SKkaIas=;
        b=jCQiCCirDVnhqhQ1IOwYezVGxYO6+Vxlf1XnDlfzY7V62HdZCTbInFGl7WB7NsHCWh
         3kxsgOvPDhsEDse6h6jRkIfaSsjYcm8G4LXjtuQZ4HlEzCNQsYRHrWhr+P0K2WOGm+ta
         v+86UjtLpw6T4LlCEnHbbrtiWPhK6ikrYF3qhNSUMB6H7JQrsO+SnI6IkSMUwo86wzAU
         jASWtdqufwIlGNoLEj0Y0R8DsnLMvmF1XEd5RZz6rXHRW0ud9tkP1liE23x/ZvaUNHpQ
         4qJmxWhWllK4Y9OuM+9XCNbVNydGqyn31SEXuWh6mKhiQWEHvBtH6tOVlaLYOfC71QIk
         HbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70lfioNuAj/Ldn/hkMoS28PuEmF1/cpUW0s4SKkaIas=;
        b=R2bvxJygdeg3wjnelPt5MBKHp+gbXfVF8PRlQCfejhYjU0hUmF8LSlIr2UoTkPEFw7
         FisusWjr3uEOM3eMflTXWZcge3uzbKYU/A5LF6QU0YAPL0eRTK8l+OMCcJ+baz5IkjUz
         JG5bkmwueNqF0PFDu5sGbf+eR28iUE4H+pJPphLshd74fjh3HKzT89nTFuzCxMPXWJN5
         YD7Yi8qNLH6eXcB7iJnx6/XbKkXuyStXllUDsY5PUztD6Qp/6gk7Cq9+joIFp1n7zI52
         HDbFrmjzthnVD8Q0fnlTbWIDDmp+1Cg1vXNXH9SOaCVJ1lQVMWdCtGEM67vL+yjwiNr6
         Ihlw==
X-Gm-Message-State: APjAAAUZq/LNtJnQ8+yxgVcLZd/M3ptus1Z1BwiqHCTOEP4MlKJ4yOAw
        LmNiaae56tOMi9ecnuIKImHMUegAx6SV/EkPyj3grGXR
X-Google-Smtp-Source: APXvYqz84v21tBVjguah6amB8yGJXN7Fs+Y2+wxRHWy2SedZtehCLKXWX1scC4ZB/rhSC7/kKrgk2hznzkQIDGraKNE=
X-Received: by 2002:a63:3c6:: with SMTP id 189mr31419958pgd.4.1574680526578;
 Mon, 25 Nov 2019 03:15:26 -0800 (PST)
MIME-Version: 1.0
References: <20191121155743.28755-1-info@metux.net>
In-Reply-To: <20191121155743.28755-1-info@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Nov 2019 13:15:16 +0200
Message-ID: <CAHp75Vfh5PhGDFCZ0RZuvYwT_4A3nnfJhqnhThEXr=Dq6ie7ZA@mail.gmail.com>
Subject: Re: [PATCH] platform: x86: pcengines-apuv2: detect apuv4 board
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 5:58 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> GPIO stuff on APUv4 seems to be the same as on APUv2, so we just
> need to match on DMI data.
>
> Fixes: f8eb0235f65989fc5521c40c78d1261e7f25cdbe

The Fixes tag format is wrong.
You are not first time contributor...

Also the question why do you have it here? Do we have any regression
(something worked and stopped working)?

-- 
With Best Regards,
Andy Shevchenko
