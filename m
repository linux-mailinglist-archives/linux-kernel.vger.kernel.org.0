Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80CE5E7993
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 21:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbfJ1UHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 16:07:12 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35935 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731729AbfJ1UHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 16:07:10 -0400
Received: by mail-oi1-f193.google.com with SMTP id j7so7016643oib.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 13:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3mQDuj70BWGu3VV82uhzxy+YFUqHzoQtIwn3n2CdLRE=;
        b=IKRTi0Ru0Z2CZbiYPkjt54bUYiDtVaLg+wn4YyYerarxbCvkOD2U/mcIHPOQz64Haa
         XrfFy2TQFH5aVL0nzNtKDHymWwtz5Ccjl7VFl4vKgvaTJ3oRibpddsJMnqf0ULhxNPxD
         v96ZxjlvApCzyCG0XcjM9amYcFNFK2JAHQQE2pycicmBnkZ9I0lHDly7sdJZR00n3OKx
         7ZLenlwm+qBBy0nDvOU744qKrRA/MKmsGi+kHLCA3f/apkLPZHPwgQdYfYyFFshmxlv6
         OaWn5K/e5yKAMtTqqvXjQ6DVPpPyFuq7sLePYWBM4vbM8IuPyytnSeAimXkVGKw1MFw6
         XbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3mQDuj70BWGu3VV82uhzxy+YFUqHzoQtIwn3n2CdLRE=;
        b=ZjEdI0O/GcKtnUDaxwpEaMtrwnOsYfkS/dU10ogqB3edmjJcOnJv9Vu8CIJE9Ijy7U
         Xy88FLxrVi7wBnFLI9HfKvjyLqgZSUhHd0QpwHtqwEW4vsViBO/zmfSPWqLUkeh2NQVY
         2C9gTih7VQ0QntyMUaaIvpAXA/BGilo7RicEa8fEkxflDlu4V+6xC8cSc4SoRVWjaqo+
         vmGsiTAcvV7dFeyRPmxEgi9SHZVUd5/xtiUSPh3I9BbxrCvlK3NrcqsiAIif3Z3xVBr+
         KrRnbI8jljOTjrkKFgh8T1UL8srwgE/SSWKFjaUNGZlRJf796DGyVilZEawhu2aEU8aH
         E2yg==
X-Gm-Message-State: APjAAAV/aawUi2ezRelnDEA6gbPeUmVtKfWoE9IRDogn4ef9q/IsrxwI
        RvUXlec32fahFcqx4enV3WmdVZ8ERHGZuzV+IlA=
X-Google-Smtp-Source: APXvYqylC8iltBvl+YFEe/HffsinC7WiavH9wE1Y1YjSAqDRpN7ImEA+uluAFRaAQ0t/m1bTvpP0U1tZuMWFKPyieSM=
X-Received: by 2002:aca:2112:: with SMTP id 18mr860588oiz.86.1572293228699;
 Mon, 28 Oct 2019 13:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191026235214.GA11702@cristiane-Inspiron-5420>
 <CAGngYiV0hCjXigVhijoTmwMfS4mM+hC-aVFsu6VDT-WmKsNsJQ@mail.gmail.com> <20191028182847.GA2311@cristiane-Inspiron-5420>
In-Reply-To: <20191028182847.GA2311@cristiane-Inspiron-5420>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 28 Oct 2019 16:06:57 -0400
Message-ID: <CAGngYiU10LH6v6Z2DvfZ9_v=zuzfmDQEzixteFFeGMf4kSeXKA@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: anybuss: use devm_platform_ioremap_resource
 helper
To:     Cristiane Naves <cristianenavescardoso09@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 2:28 PM Cristiane Naves
<cristianenavescardoso09@gmail.com> wrote:
>
> Sorry, I was searching for the issue only on outreachy mailing list and
> had found nothing about it.
> I didn't know about these other mailing lists.
> Thanks for the feedback!

No need to apologize, most of us are always learning !

Next time, you can get the mailing lists to check by running the
get_maintainer.pl script on the file(s) you are going to modify:

$ ./scripts/get_maintainer.pl drivers/staging/fieldbus/anybuss/arcx-anybus.c
<snip>
devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)
