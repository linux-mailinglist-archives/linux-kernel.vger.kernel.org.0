Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A732D2CE1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 16:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfJJOvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 10:51:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43469 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJOvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:51:23 -0400
Received: by mail-io1-f67.google.com with SMTP id v2so14282073iob.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 07:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSn+IbxhWIYTbk+iRSpPFibjYFIoDZf+e+FxR6Ivkjk=;
        b=CMiuA1bAsqhGMhz0TB4PodgSVEo3g5QjP1Fu0Ynm021+h5UsusJeQOOrhisvEnWTe2
         bN+KehzdyJghCtDEti1ENtTDNYHtxdbVMnFtroXadVWscgHy9EnqpRUMRPZWE8JYBSc2
         JPHuvbI4LJE4TZd/Pw/1XVTuJYrUqb/hpLgI1JT7f7UBdJsJarltl3FjZjxzEyPMDS7T
         rqOdkZjBx6BrVCCvqgsqX8K+ILXYpkFO+3Xg3bMXhf3denPUNMsxr3V3XQ/eunajRG6/
         iCjm8UQGXTrr2qURaiQvx0OU5lqNmUr3GMyj0fUvXA2dcdYJpdLnj2qrUhbV1+B8CW1t
         563w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSn+IbxhWIYTbk+iRSpPFibjYFIoDZf+e+FxR6Ivkjk=;
        b=Rroe7PaWTfLhrX0dzXwPoYvTR/HmGL1SlEJOYM/gA6G2ISNIU0AkYtWywNAaSoIeXj
         RpxUsJpyAf0G4dhOLTszirZb3LaCkEX4FRxTZ2SX0wIpFlMEsLYfEfH9NdKEX7KO20JU
         DaQdPUGeNz0bWIAYPZk8yPTAH464f6ZlUNbfJGEv3sSq9GT8ClPl8ieJ2oogxvDoNgH0
         s9XcP1aA8mInHytMYrSUgn2YT0mlz1/OcylncNMfYtti6OSkvzntF9czCdEz5jTwThsW
         70SgFUVOBqMVRTCEqDthiBmUQOKKS9avHTLedXVU86ILzFj6+p+IC9C6w1MKx4/u5hh7
         ULzA==
X-Gm-Message-State: APjAAAX0oDFLzJNRjBOdF7gbd/Tty11s5SASq3L9lqvY2GX9VPpuHEif
        9b0bOQ7mx85LTEWPSMspb4RrsJ/jNfMiQ0humiUiwg==
X-Google-Smtp-Source: APXvYqx8HaNdT/+Du1N7u8XZJrZL2oN5WfxqTEykBcboGo9OOgOaPal6nfU64eR4Z/J4NuhEvJLwgogdeek2MthjUQE=
X-Received: by 2002:a5d:87d2:: with SMTP id q18mr402942ios.46.1570719081321;
 Thu, 10 Oct 2019 07:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190925150308.6609-1-joel.colledge@linbit.com>
In-Reply-To: <20190925150308.6609-1-joel.colledge@linbit.com>
From:   Joel Colledge <joel.colledge@linbit.com>
Date:   Thu, 10 Oct 2019 16:51:10 +0200
Message-ID: <CAGNP_+WxQSd_JBoWGn8H2CH1aY3PmZGcgrHziRGKTH8OJz33Vw@mail.gmail.com>
Subject: Re: [PATCH] scripts/gdb: fix lx-dmesg when CONFIG_PRINTK_CALLER is set
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     linux-kernel@vger.kernel.org, leonard.crestez@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan and Kieran, maintainers of scripts/gdb/,
CC: Leonard, most recent contributor to scripts/gdb/linux/dmesg.py

Could someone look at this fix please? Is there anything I should
improve in the code or the format of the contribution? Thanks.
