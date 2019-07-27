Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5BC677B19
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 20:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388058AbfG0Sfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jul 2019 14:35:38 -0400
Received: from nbd.name ([46.4.11.11]:55988 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387841AbfG0Sfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 14:35:38 -0400
Received: from pd95fd1e9.dip0.t-ipconnect.de ([217.95.209.233] helo=[192.168.45.104])
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hrRXa-0000Dh-HQ; Sat, 27 Jul 2019 20:35:34 +0200
Subject: Re: [PATCH 2/5] MIPS: lantiq: use a generic "EBU" driver for Falcon
 and XWAY SoCs
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        robh+dt@kernel.org, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        hauke@hauke-m.de
References: <20190727175315.28834-1-martin.blumenstingl@googlemail.com>
 <20190727175315.28834-3-martin.blumenstingl@googlemail.com>
From:   John Crispin <john@phrozen.org>
Message-ID: <d0ef8f73-3555-b53a-eb2b-40066827b6d9@phrozen.org>
Date:   Sat, 27 Jul 2019 20:35:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190727175315.28834-3-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/07/2019 19:53, Martin Blumenstingl wrote:
> + *  Copyright (C) 2011-2012 John Crispin<blogic@openwrt.org>

could you change that to john@phrozen.org please

     John

