Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A970A9205
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 21:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387675AbfIDSpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 14:45:20 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34160 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731813AbfIDSpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:45:20 -0400
Received: by mail-qt1-f194.google.com with SMTP id a13so25616740qtj.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 11:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GzPtnoZKBXej/mlgs8PtbOknEj9n3Us0gAfYmyqSvjw=;
        b=VdlMxU2Og1meLhN3mybLTe3Z8QrknnLkvmd5oiDCaC5TdU0TciUe8RsrkaULjcbiIv
         PgCfv2o7h/AAF/A10Cqif9bj9DqzD5OGQYoSRPiu1/TR5xFfzKYFeTqqD3mhxqVkCW9e
         eSn+a/17Hz06iEh2Q89xQ7DBbc9C5c0bxU8n/odE6sNjHVBIIZaTYXnUwpB2/0/c1CQ2
         iFQl2cMqQR1aIt20J4/M1O1p+5ngrULs+maNx+Vi+t4VF1vnBAbHljdR9ePTnWWZbBVe
         cAPFrrUy0mX3O+iQV1yjcqLo48rvi+DYuqVSfNBG2QWgYMvpIZY9MxIt1JPKHmAAkmV5
         FVxA==
X-Gm-Message-State: APjAAAU5pMx/vEzMVWOOk0dfWdqLxDxtjjLOGHcbECuFLq3jDLplu+6l
        ZdPkocXjaUpkpBRLUkUG4G8L5TILRFBru/8ZDJg=
X-Google-Smtp-Source: APXvYqx7VEb6qlalpWvOqPpVbV9Zbwk6y655ZqijP1UIaRUoQEo5Zrlg2JVRl5ZF1ZBXcdAB8GtncAVL/LandToRpWI=
X-Received: by 2002:ac8:5306:: with SMTP id t6mr27338812qtn.204.1567622719308;
 Wed, 04 Sep 2019 11:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <1566875507-8067-1-git-send-email-santosh.shilimkar@oracle.com>
 <CAK8P3a3_NWWBFrpNpbPH9+47Segi_EaYx2jx5jvPhYJJqR+a7A@mail.gmail.com> <3af4da24-2246-ff94-b83d-2b6ada4fc362@oracle.com>
In-Reply-To: <3af4da24-2246-ff94-b83d-2b6ada4fc362@oracle.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 4 Sep 2019 20:45:03 +0200
Message-ID: <CAK8P3a2cM+DCGX80otq5y37qMPtuM7jz=Gocz41b6=fOkEiXQg@mail.gmail.com>
Subject: Re: [GIT PULL] SOC: TI soc updates for 5.4
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 7:35 PM <santosh.shilimkar@oracle.com> wrote:
> On 9/4/19 6:13 AM, Arnd Bergmann wrote:
> > On Tue, Aug 27, 2019 at 5:12 AM Santosh Shilimkar
> >
> > Do you have any dependencies on -rc2 in your changes? If not,
> > could you please resubmit after rebasing? I can also just
> > cherry-pick those three commits if that's easier.
> >
> No dependencies. Can you please cherry pick them this time ?
> Will use rc1 for future pull request(s). Thanks !!

Ok, done.

      Arnd
