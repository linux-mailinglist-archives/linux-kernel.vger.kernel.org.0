Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B93F623F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 19:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392840AbfETRhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 13:37:32 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40302 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389405AbfETRhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:37:31 -0400
Received: by mail-ua1-f68.google.com with SMTP id d4so5561137uaj.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vDBzgk3+2zzaDlSxwytUrA3Kc0EghhVaruTPNWK1ttg=;
        b=CwchGZjIFzmqStPHXdkdMvjtXevOL6aMDz0RbbxhvTvOywv3R7HbSxVIiPR86vVgVJ
         28yp6/OUTu6GifEPNjnYBzsfPg5Y7BbwwV5Ty4ILdR7ZbBYLoKzOGlZ1hMwqgeyZohQS
         a9Xty3qBzDrM1VhvrAeqYsd8bm4McRK6eMvwStNI7jp8RC5DjasBTN49ChbDaScmiIHc
         LTl2jGq3y/n5qeMsGBeWktpO3+3aP8DzWvndvfXt1nfhBIsEP6nW4S6oWCWrYYgtNWmE
         SMz99yiCt+Utdgd/gzX6yrRr7ihWyoWsQAjda+WeCB98a3ybcjj/r3oR4U9vY176w7BS
         0c3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vDBzgk3+2zzaDlSxwytUrA3Kc0EghhVaruTPNWK1ttg=;
        b=Ir+xREt3Bg8yEJsCVRP8Xina3xefOTn4RP0LBPgmrytmnTwjd4M2kqO4wVqaA92iq5
         1HP7Zx0egithXV2ERSY6/nf3+o7yt9xA2OpKiRWZXJeAyDYotz3IBCa9x+g0lpyuZcAK
         Y3whnj+3NW/O0C+X/k8VzNgB59x891VUWaH1iRN+JrelMbbJl7upQfwyqVd7hFWxXkQ4
         ZjWB50mmq4LywVlJDP6F2I/Wilu/pxPhYG+2IjjcjJTlg+wat2mmuZYI5Xz2BCb7XrPv
         rDOYV5UaS4YhK5ngv5tnd1zS5HrW+Cn/BnEksREfsj/MrX4RFvH6TGhIJszJaSoqPFxS
         8CSg==
X-Gm-Message-State: APjAAAVqfrCF6ERw0QfJXG4llCKlV0yEz4M1crv/pCIlnjBhlAupbN1W
        wNiPNNU1r27Xs7da5sOQEVoQJb9kK7MvC/PCHOkBlA==
X-Google-Smtp-Source: APXvYqxP8zxzm4jZKGosdcwN4a0RkbFAaC28vOtz1R97u76s4VbaoqHPsL53swQmuIAJyZjvBa85qqDRttnmEtWmwhM=
X-Received: by 2002:ab0:670c:: with SMTP id q12mr13594032uam.106.1558373850690;
 Mon, 20 May 2019 10:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190517213918.26045-1-matthewgarrett@google.com>
In-Reply-To: <20190517213918.26045-1-matthewgarrett@google.com>
From:   Bartosz Szczepanek <bsz@semihalf.com>
Date:   Mon, 20 May 2019 19:37:19 +0200
Message-ID: <CABLO=+mSkR8fwm5dDB2757OK=BKZGM9jHR6OuCkzazgFcVy=dg@mail.gmail.com>
Subject: Re: [PATCH V6 0/4] Add support for crypto agile TPM event logs
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Fri, May 17, 2019 at 11:39 PM Matthew Garrett
<matthewgarrett@google.com> wrote:
>
> Updated with the fixes from Bartosz and the header fixes folded in.
> Bartosz, my machine still doesn't generate any final event log entries -
> are you able to give this a test and make sure it's good?

Yes, I'll check that and let you know. May be later this week.

Best regards,
Bartosz
