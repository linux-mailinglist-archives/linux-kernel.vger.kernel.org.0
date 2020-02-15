Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8264615FAAE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 00:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgBNXeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 18:34:25 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37587 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbgBNXeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:34:25 -0500
Received: by mail-oi1-f194.google.com with SMTP id q84so11088481oic.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 15:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bDwgZwWEZBQk29NnYfaGxDMUMeCdsRhSZX1d/rIRhxg=;
        b=OOd5U6oKpovMR6LKPXMaj8uM7Mw2QJILaFv1jCn8dj8LNnoYbRfBdI6LICyZRTke9A
         vBS3qYHaUpSILlCiysIyflj8cmWyTq7jOnN0ctlCO/9ZM0tMR0/fhFllptCByH8WNapx
         xiBZirFjgWTgNYTkkjrcMJDdFfV+j2uacM++cCbGmtAed1Dd2EgM/DlBlGqTP1G/c85X
         iBHzbQOiRNi5Uos3mBcxtHFcLknEC/v10ui/M8CwxwjwQ1YqbHHrncLwCc3cg9FCuZkK
         3qMiYL3ZXd0NxDFqJpxYoRcu1PorX/wCWV7svDqPs2U6ko7ferg4QrKcVtvyOMjAteFS
         Fa5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bDwgZwWEZBQk29NnYfaGxDMUMeCdsRhSZX1d/rIRhxg=;
        b=nQsZFA9guqHulht2hbFc8OpNdB7pV4opTZZyrvXBr/UPqTRb9Gpom86rHmtkhGRRqi
         kOD3l4Dgo08sXhLw1Ajm+vYg33EOkq+EEb6xRMwdn6cKxJlUJausvDzst7Qzu3hNO1we
         WvA1fnDnuJuSw4eGineIQ+xLhjCUXFco2J6vhjuO4KY5DIlqYcbp94vUCH/97ZLXvBl1
         SZE1HS2GSQitzZwkEmzHQRMLmJ/4UD8wyLbfmBOP3mbLcEJwtl3UeUlMm/hUFgLwPr8q
         +KQ/lya+4llenEtdyF5892bLjEBISjne/cIB87PR1moe8q94zl88bpsG8sY0DrczWbpS
         Shig==
X-Gm-Message-State: APjAAAVWVC2t+RVHQSmoCsS3itmX03TDiiW9d13fINFSrjGkONLMZCEi
        jnWI7a4opci69UKS+s6yAA67V4EbscTfGwBNnNU+OrgHdXQ=
X-Google-Smtp-Source: APXvYqyxEEchfAIYCAJCyFLYCbJyC5TN4Yg6b/NqwWNA0uFFN3wAJLP6U99c68Vkxn+8vw95fl2ig1lswc/FIbYIKTk=
X-Received: by 2002:aca:c551:: with SMTP id v78mr3569733oif.161.1581723262981;
 Fri, 14 Feb 2020 15:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20200214233226.82096-1-john.stultz@linaro.org>
In-Reply-To: <20200214233226.82096-1-john.stultz@linaro.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 14 Feb 2020 15:34:11 -0800
Message-ID: <CALAqxLVukbQETMSfjc3OsEE4BGt-uXxw-NTqgLxA=ja4JAVD4w@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Extend returning EPROBE_DEFER for two
 minutes after late_initcall
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 3:32 PM John Stultz <john.stultz@linaro.org> wrote:
>
> Due to commit e01afc3250255 ("PM / Domains: Stop deferring probe
> at the end of initcall"), along with commit 25b4e70dcce9
> ("driver core: allow stopping deferred probe after init") after
> late_initcall, drivers will stop getting EPROBE_DEFER, and
> instead see an error causing the driver to fail to load.
>
> That change causes trouble when trying to use many clk drivers
> as modules, as the clk modules may not load until much later
> after init has started. If a dependent driver loads and gets an
> error instead of EPROBE_DEFER, it won't try to reload later when
> the dependency is met, and will thus fail to load.
>
> Instead of reverting that patch, this patch tries to extend the
> time that EPROBE_DEFER is retruned by 30 seconds, to (hopefully)
> ensure that everything has had a chance to load.

Oh, and of course I forgot to fix the subject line and didn't see it
until git send-email was done.  That should be 30 seconds, not two
minutes. I'll fix that up for the next version.

Apologies!
-john
