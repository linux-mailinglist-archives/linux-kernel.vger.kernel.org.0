Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7DCD6A448
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 10:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbfGPIwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 04:52:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32851 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfGPIwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 04:52:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id x3so13150995lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 01:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XyQtv8q/vojaY1D+1nE9nEqdizDyuspw+4fU4V90wfg=;
        b=h5BnzYaeTvOlH06pndcuIZMyPpXzgZFv4CdRfrazxDwaTYTWGAhMJJ113o9/HjLPTl
         TEKInE1moxeMIIt89WjjbS2JZFvGkRLPTRDv1889fKRSTRMXTNHjkdUyw2PkC7jM5Hxn
         I+c75HbDAdEdXRHgyTOvJopT6y8fD36j8m4ioAgiDjfJfoe80ioBjSFCUrZMLWOK35vu
         ozPXP2/NFlcAjlO3NqDmZk5WVgnyNeJVB8GEfiA23X8fbX5Qgn7czCxhqRGffjSA1X2W
         iGIfE5dg15UGF+WGh6o53294EcQDsG9M3FTzfifZVytZz0mY/KsQNrho5379BJ7cKtYu
         4OtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XyQtv8q/vojaY1D+1nE9nEqdizDyuspw+4fU4V90wfg=;
        b=IbHm1IUY3AqiGxngmSXC0tWZ2OnQfeWba+qDGUomLe5LTcJaVClNFxo4JSMaCdvij4
         8auvuM/rFnGYCwa5zhhAwc+AQj6aEZFWxLbnNqto9nmJhuT3474Sjx3sBuT3nnWiec4X
         5XgQslzu2pU09DP6VUEJK3rrVypl8apXmIipJJr9VwsyI5xa52gA1kDMuHdF6LOGfOYe
         +qmEkojo+mrkuuWcy90y+CwBKih3mjYv7O+E6XN3AIRRTtqcIuyCopTcFChztXPNBAlT
         lBeTgAWY7nkF7jD3V7EktUi8cIHP3WU9x8bYPOq+j2fRpRCHeKTnAkFZ7PGdJDgA9oJO
         Z3Fg==
X-Gm-Message-State: APjAAAXHtssyFMT+eQFkkfO+aKVXDI2rxu4OkhMtlnvmpLNygQtvg0D4
        NrYRbgo5A2tgF3XofwtYAkqwQQC4ZoaFxg==
X-Google-Smtp-Source: APXvYqwYuqhrW3TJhCJZ7PX4BmU4vW0ooe7NeWyaoHIu87HRNCS59SvmIGeZ1Cdj5vYOEfwejxR2oA==
X-Received: by 2002:ac2:5231:: with SMTP id i17mr14127734lfl.39.1563267160476;
        Tue, 16 Jul 2019 01:52:40 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:486f:abb9:dd58:ac0e:e00:e686? ([2a00:1fa0:486f:abb9:dd58:ac0e:e00:e686])
        by smtp.gmail.com with ESMTPSA id i62sm3577698lji.14.2019.07.16.01.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 01:52:39 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Kconfig: remove HAVE_LATENCYTOP_SUPPORT
To:     Fabian Mewes <architekt@coding4coffee.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190715160849.25964-1-architekt@coding4coffee.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <77754e88-ff5d-2021-60f5-80417d61763c@cogentembedded.com>
Date:   Tue, 16 Jul 2019 11:52:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715160849.25964-1-architekt@coding4coffee.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 15.07.2019 19:08, Fabian Mewes wrote:

> HAVE_LATENCYTOP_SUPPORT was removed all together in da48d094ce5d7.

    You need to also specify that commit's summary enclosed in ("").

> This commit removes a leftover in the MIPS Kconfig.
> 
> Signed-off-by: Fabian Mewes <architekt@coding4coffee.org>

MBR, Sergei
