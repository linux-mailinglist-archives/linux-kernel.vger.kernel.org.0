Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A743B1438B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 09:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgAUItG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 03:49:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbgAUItF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:49:05 -0500
Received: from linux-8ccs (x59cc89bf.dyn.telefonica.de [89.204.137.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBA9E22522;
        Tue, 21 Jan 2020 08:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579596544;
        bh=DJSyOs52eNVSYTjAHyLmd3vu6c3t+wDc4mZcbjSd0C8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gs46cBiiSiLl+w1Vc4ZFQSgHUJr3PvI2NUS8MrrwU3Lf7iea4enV7KRhQAm0NhrE4
         CODrEvpXvoEbzDu1empanyCiEYRRLu3IgMW9LXpFYC0LA7tAnX5575lO5JjYKjaC3w
         CcGuoNjLIj8d8PAsYW7kYxoC4vIjpA0ySipXBlig=
Date:   Tue, 21 Jan 2020 09:48:58 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: avoid setting info->name early in case we can
 fall back to info->mod->name
Message-ID: <20200121084858.GA17071@linux-8ccs>
References: <20200117145306.15509-1-jeyu@kernel.org>
 <alpine.LSU.2.21.2001201656100.2671@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2001201656100.2671@pobox.suse.cz>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Miroslav Benes [20/01/20 16:57 +0100]:
>On Fri, 17 Jan 2020, Jessica Yu wrote:
>
>> In setup_load_info(), info->name (which contains the name of the module,
>> mostly used for early logging purposes before the module gets set up)
>> gets unconditionally assigned if .modinfo is missing despite the fact
>> that there is an if (!info->name) check near the end of the function.
>> Avoid assigning a placeholder string to info->name if .modinfo doesn't
>> exist, so that we can fall back to info->mod->name later on.
>>
>> Fixes: 5fdc7db6448a ("module: setup load info before module_sig_check()")
>> Signed-off-by: Jessica Yu <jeyu@kernel.org>
>
>Reviewed-by: Miroslav Benes <mbenes@suse.cz>

Applied, thanks!

Jessica

