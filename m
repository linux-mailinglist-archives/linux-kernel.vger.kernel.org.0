Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3248732CEA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 11:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfFCJb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 05:31:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbfFCJb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:31:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D67228006;
        Mon,  3 Jun 2019 09:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559554317;
        bh=EMN8Iq59ijXBnEHjrjBo+85LTiDDMfUpO35bS9zD+hA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+FM+LyaDtTO9EKGzJuxtIkNDUabPe0tJvMKkEUDdOe4Nm5SoFmNliu7cmoDPRXir
         BA/Txj7hGqIEzAhO2Vat8/5P2GGHHms8+HAX/bFc1mkNgNF7HtZUIhQVnf8ugoMxSB
         ek+G0XoWMjgCmdTS8UASEtCUMf3ulub46wFJdFgY=
Date:   Mon, 3 Jun 2019 11:31:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v4 1/2] drivers: base: cacheinfo: Add variable to record
 max cache line size
Message-ID: <20190603093154.GA29175@kroah.com>
References: <1559009814-17004-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559009814-17004-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 10:16:53AM +0800, Shaokun Zhang wrote:
> Add coherency_max_size variable to record the maximum cache line size
> for different cache levels. If it is available, we will synchronize
> it as cache line size, otherwise we will use CTR_EL0.CWG reporting
> in cache_line_size() for arm64.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
