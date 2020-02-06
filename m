Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3E48153DD0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 05:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgBFEOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 23:14:25 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37215 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbgBFEOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 23:14:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id d3so4249513otp.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 20:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4YK4pLNzComAb4RRWalE9dRpSr6kTwplmClgTn0UWb4=;
        b=PAu6LbFgkInaD/I3fnt77LxSZJFmHkyKDvDWEI5UyTUgY4uuCecKZ5XYEHCcYTGNvC
         IhqmrP40a27uFYDl0Jz0ux8ycH5Rcfu4JQtztjYSwvsbQwNBagxztJwKr4B0asvQ0aie
         mLkpDgi2UxItCv2DzBnCMjpPTdYFyJCo3xPPBTkItapDE3C2obwsQg3x1X+mhr7HPzkr
         KRvCSYglf5a++dFraoZDYbL+qKevobyDPYtYLh5jk36+1/l+SqAK4nrW2OfiOg+iib/o
         pgHViExC6kXu6hGg5bH6018gdDWdtM9+BwXRCMAuhqNNSK5H1jZYU6ctfO7iOW69GAZJ
         wOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4YK4pLNzComAb4RRWalE9dRpSr6kTwplmClgTn0UWb4=;
        b=Q4n1dJtlnQOEG/LwKPoXCo4r4zck8ur0uAygzOELwUOkdCV9jUHqi3kyEhc4vfp9CC
         WhOjFDV8lFgOZG0sJPgpRUUWtxv/tIK+tjljWZ/TldPisFuuznLwXjSlAxBlKVDG/pQW
         DjrILv6lFwf1qQ59ABbvpL/sO05Nu3fJWPmKLAdpD9gbmal9WCbOYqoVdU6L1waCkQcX
         yBzMJ3Ijla49rSrowm6be2n8o7ZoHkgEDvqY0sXg+l35h08ndIXkjraDJq5MwmLHaJ32
         lN7mqSOK3IJVo1S/0V08g3ZuwIFxuv30YOuvi918BGmI/Lp1H0/pQT6mAWArOaftI2pJ
         3M7w==
X-Gm-Message-State: APjAAAUji2jhXClaB+VFtZQqvXK2Olz3b78Edx3T7bpn1VaVTl8DaMDd
        no7AOCVp918TQ+dwvGi5+Ws+KQXiG21Qq1Lo3YJMcNyj
X-Google-Smtp-Source: APXvYqxI4mUzUsqZ0Sa+xPDkLkdtxf71TqFdTm7+a8LDEGYPR1/1v8JMu9QEFrR9x3MOi2R+O/ZUnkHrFPijAeBuNbU=
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr28615291otq.126.1580962464419;
 Wed, 05 Feb 2020 20:14:24 -0800 (PST)
MIME-Version: 1.0
References: <ca53823fc5d25c0be32ad937d0207a0589c08643.camel@perches.com>
In-Reply-To: <ca53823fc5d25c0be32ad937d0207a0589c08643.camel@perches.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 5 Feb 2020 20:14:13 -0800
Message-ID: <CAPcyv4g65_Jxv3GUHsTtH6KmR=AYbx4s+TAC+tLE8YeLNiH8pw@mail.gmail.com>
Subject: Re: [PATCH] get_maintainer: Remove uses of P: for maintainer name
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 5, 2020 at 7:23 PM Joe Perches <joe@perches.com> wrote:
>
> commit 1ca84ed6425f ("MAINTAINERS: Reclaim the P: tag for
> Maintainer Entry Profile") changed the use of the "P:" tag
> from "Person" to "Profile (ie: special subsystem coding styles
> and characteristics)"
>
> Change how get_maintainer.pl parses the "P:" tag to match.

Looks ok to me:

Acked-by: Dan Williams <dan.j.william@intel.com>

...although I was not able to trigger any unexpected results running
against drivers/nvdimm/.
