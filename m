Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2841CDD0CC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 23:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506060AbfJRVDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 17:03:08 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41011 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbfJRVDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 17:03:08 -0400
Received: by mail-qk1-f196.google.com with SMTP id p10so6611583qkg.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 14:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w5yfTzlXuD4kav5HMjCh3XSfoZZpoehtbD9nhzYMyUM=;
        b=YJ4zJBnOuYfs3IkYqza76LtzacYPjLmzE1cNIVUWPWz2I0HHMP/AG1snDhBdxcndda
         qw5EzeWr8ANzVlfsn4a6eOjVa8PDZiQ4pdtSBDZ7qnt/hetcMXUycIb4e/VSfwEvdTSr
         Yf1EDMGPNUeE96tDTbvbaSXACVbmO+TavnO9M/+y3Q14jTIq5aHb3nNobu3YsFZ60o75
         KX5/tzztz2ov7+K0HXdIj1X7c/dPlSqFZujA4aixVjzeRdnSIKNult7EpppnRmVq3aNC
         crCQlHQgq7GW/+SbgcqiOas9Hnwg4rluV7KDaBTV6mr5QUMCXkA0UG7o0nu4NEAiAipB
         Rrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5yfTzlXuD4kav5HMjCh3XSfoZZpoehtbD9nhzYMyUM=;
        b=pn0NYVPKwtfI0oz8GUf+XRZofGCDCYCAJtZL3rah6hqNR05ymLUrAf5+dXnNuhqavi
         vqoHOCPpgeLavqe1lszgsi9r4TxkJ88m8xM3hxwqHspSRNn7ouPr6pMqlDl8gbXgEE39
         b3v+jMukEDOQxdlIvWCJWa7s/vsA1kXmDr8TFwRc3H9jV6zq7m/jIYBR+46sfvdHcI0x
         QLc6P36hVKb3TgCzCv6meQTcQQfLSYFu2YjHElTMSTWPwoSKayzRAJwVMCb6rqC7lpHm
         LfTvystmCtJ5+Wdx3qmS04kCBvdLwQosvUF0Xlyuv7VWrDImSMF1ZAjUuwo5H/pJyYrw
         AQOA==
X-Gm-Message-State: APjAAAWC34Lyq89FQ/xY2O7k4i0WVwvhqhX6E1647p9Kl90ypKup0lB/
        IKuOqbYGQG5EwuY4aX7RXZAyiGnLKB0tqrv1PSPvoVM0k9U=
X-Google-Smtp-Source: APXvYqw8tNu0ZEcr9cUYkJv8QaKxcGJGz7c1mQDdMa03FSxMEnvUroWtRP1aKSvz4MkVzAn/r0dtQ+UUPuHmHpj4J9c=
X-Received: by 2002:a05:620a:242:: with SMTP id q2mr10896151qkn.87.1571432587081;
 Fri, 18 Oct 2019 14:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191016221148.F9CCD155@viggo.jf.intel.com> <20191016221152.BF2171A3@viggo.jf.intel.com>
 <CAHbLzkp_2UD50Vt8f_atxKcz4x8J3GB3YzTqMOd6Src_y2Yg2g@mail.gmail.com> <6ab6ca82-71d4-bdea-ae95-e0bebb5e71df@intel.com>
In-Reply-To: <6ab6ca82-71d4-bdea-ae95-e0bebb5e71df@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 18 Oct 2019 14:02:54 -0700
Message-ID: <CAHbLzkppnNBXVkQ-eZx1=USaaKJWE-dd3_SkFk+y9vkMsm0oMQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm/vmscan: Attempt to migrate page in lieu of discard
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 11:15 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 10/17/19 10:30 AM, Yang Shi wrote:
> >> +               if (!PageHuge(page)) {
> >> +                       int rc = migrate_demote_mapping(page);
> >> +
> >> +                       /*
> >> +                        * -ENOMEM on a THP may indicate either migration is
> >> +                        * unsupported or there was not enough contiguous
> >> +                        * space. Split the THP into base pages and retry the
> >> +                        * head immediately. The tail pages will be considered
> >> +                        * individually within the current loop's page list.
> >> +                        */
> >> +                       if (rc == -ENOMEM && PageTransHuge(page) &&
> >> +                           !split_huge_page_to_list(page, page_list))
> >> +                               rc = migrate_demote_mapping(page);
> > I recalled when Keith posted the patch at the first time, I raised
> > question about why not just migrating THP in a whole? The
> > migrate_pages() could handle this. If it fails, it just fallbacks to
> > base page.
>
> There's a pair of migrate_demote_mapping()s in there.  I expected that
> the first will migrate the whole THP and the second plus the split is
> only used if fails the whole migration.

Ah, that's right. I mis-read the first migrate_demote_mapping(). But,
why calling migrate_demote_mapping() twice for THP and base page (if
THP is failed) instead of calling migrate_pages() that does deal with
all the cases.

>
> Am I reading it wrong?
