Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E02992056
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 11:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfHSJa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 05:30:58 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42958 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfHSJa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 05:30:57 -0400
Received: by mail-qt1-f196.google.com with SMTP id t12so1136602qtp.9;
        Mon, 19 Aug 2019 02:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JFfcd2aWnD63uHxrGGrBMx20FuJCpjkBSuAwl0BDHEA=;
        b=YdC/NSNaLxX9MHpFGBgW6CU7EZ1XTRHLmAXFhRSy5ehgbthqvmQcm39HaAi5OGQIHb
         0eNSjYbbqlfjSDyujt1P0JDhw5rMV0WiECJiU3e+T6uleOoDaWmni9BMy+03LoVqVVsj
         Ghzy557/dBTOuqxVM7ewVAsTXoDhI/4lBqwIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JFfcd2aWnD63uHxrGGrBMx20FuJCpjkBSuAwl0BDHEA=;
        b=DBiiP9SRZTGLG7RXHvse/H6i1zcfU6U6BS84oLGOlRG0pzqX9L4noSDTEaZ4/u2gVU
         AkBO6h1rmMSO8dWF1Dp1N8iY5PhEg950J/rLO7/9Z9grPTGqG1FRwz23zKK2doSEHMO0
         zhC3Rz+6VYTqkKWMzs5mOGTzut6lSxQUyowI0E+BVGD5fPu7TxTdQqlYPBaZptS9R4V2
         gBlKBTCUZZsVUZrSWOsCsRui8GkQbYVkIgJD6/Ipf/Wq4kARNdxlvEgVDhcTVc/uT4fX
         L3NHSUsWsEJ4ClU/6psRfIY9arZtlHCSai+ogiyJqsmSzpF5aNKa3m+HBV9r8Ee6xF17
         Qm3w==
X-Gm-Message-State: APjAAAVMDBUiIs84mKU2ndRNHgo3jsK/vTYDpspNw+LL27qMUvizNk85
        Y3UPMmTAAu7RiqPQQKXZd4+fxc96xS1k0lYvrAA=
X-Google-Smtp-Source: APXvYqwdbyD050l1JQMNhqORypwCwlewcXrshUh6xNe/3T/3iFa5hXDqHmKkUkqt20f7MbKR1wov3rIhLLbsktfmLg8=
X-Received: by 2002:aed:3e6f:: with SMTP id m44mr20030489qtf.220.1566207056483;
 Mon, 19 Aug 2019 02:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190819091509.29276-1-wangzqbj@inspur.com>
In-Reply-To: <20190819091509.29276-1-wangzqbj@inspur.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 19 Aug 2019 09:30:44 +0000
Message-ID: <CACPK8XfAAU+x8d+=7ALDAUSynLG=8KUWD3zDZqaHRnh5pajDKQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] hwmon: pmbus: Add Inspur Power System power supply driver
To:     John Wang <wangzqbj@inspur.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        duanzhijia01@inspur.com, Lei YU <mine260309@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 at 09:15, John Wang <wangzqbj@inspur.com> wrote:
>
> Add the driver to monitor Inspur Power System power supplies
> with hwmon over pmbus.
>
> This driver adds sysfs attributes for additional power supply data,
> including vendor, model, part_number, serial number,
> firmware revision, hardware revision, and psu mode(active/standby).
>
> Signed-off-by: John Wang <wangzqbj@inspur.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>
