Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC18D13A7D8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 12:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgANLF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 06:05:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgANLF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:05:59 -0500
Received: from [192.168.1.20] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A277A207FD;
        Tue, 14 Jan 2020 11:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578999958;
        bh=YEOqUaQieeaEYyIs/UIoSNcK2b+X1VCflmo2aOZnG+Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QXI/sdjHnXcnWZI+hPNgXQu4mAIcE7hTsnXQN5pC8+WGSddk35v4EFlsr4H/ZW9vC
         7ucbbx4G0n/6wr23lwedhX+/SRul2NZRPaxomCxinNsiMj2fs4QStwrUYdTg/WLzM8
         wpGczX/BfzS68n7lrRy0QuDg8rz5twWKqD6f9cM0=
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer of ehv_bytechan tty
 driver
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "swood@redhat.com" <swood@redhat.com>,
        Diana Madalina Craciun <diana.craciun@nxp.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>
References: <20200114110012.17351-1-laurentiu.tudor@nxp.com>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <a8bcad8c-2354-2434-69b0-e009bd463897@kernel.org>
Date:   Tue, 14 Jan 2020 05:05:56 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200114110012.17351-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/20 5:00 AM, Laurentiu Tudor wrote:
> Michael Ellerman made a call for volunteers from NXP to maintain
> this driver and I offered myself.
> 
> Signed-off-by: Laurentiu Tudor<laurentiu.tudor@nxp.com>

Acked-by: Timur Tabi <timur@kernel.org>
