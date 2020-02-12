Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6882715AAA4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 15:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgBLOBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 09:01:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:53494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgBLOBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:01:50 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48D3320724;
        Wed, 12 Feb 2020 14:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581516110;
        bh=Vl9oWFtrvRnj/ynpV0yaxfYSghDQP0TDSGdD9cWeP2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R2lPdg74T8JyrWqBSmco28KW6WbKaFCw05f9VCD9YwUwVSkWPsHQDc6fi29AybgX+
         6t+oa/ZewL3YmPHruoS5TVRwLUC/WKQf01xseZTMKLSh3M7B8NLmQqyWt9pVYts01w
         7k1akI/vTDSjxKwnCSVnwA/ockHQD76qFEruUf/w=
Date:   Wed, 12 Feb 2020 22:01:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Voltage monitor on ZII's VF610 boards
Message-ID: <20200212140142.GH11096@dragon>
References: <20200114151906.25491-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114151906.25491-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 07:19:01AM -0800, Andrey Smirnov wrote:
> Everyone:
> 
> This series configures voltage supply rail monitoring on all
> applicable ZII VF610 boards. Should be pretty straightforward, but let
> me know if any changes are necessary.
> 
> Thanks,
> Andrey Smirnov
> 
> Andrey Smirnov (5):
>   ARM: dts: vf610-zii-ssmb-spu3: Add voltage monitor DT node
>   ARM: dts: vf610-zii-ssmb-dtu: Add voltage monitor DT node
>   ARM: dts: vf610-zii-spb4: Add voltage monitor DT node
>   ARM: dts: vf610-zii-dev: Add voltage monitor DT node
>   ARM: dts: vf610-zii-cfu1: Add voltage monitor DT node

Applied all, thanks.
