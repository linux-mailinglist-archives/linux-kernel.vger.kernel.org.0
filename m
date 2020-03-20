Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 578DA18D6F9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 19:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgCTS0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 14:26:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgCTS0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:26:33 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7814E20767;
        Fri, 20 Mar 2020 18:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584728792;
        bh=rfWQb/MXe4FaabzbbDcKizSrM7U2zTDWWYfuTq2HNdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pamQhJQKoCx4WWWQGH0ZviG7tsLdkXlFpWPA0XJx7dJmYOmdFLvUg7JQI1tSpJOuP
         s9GA8PwEYFxPWzu8u1jfBZNxbH2jQHbFCBBdeVo/iIlPYl8rqfieFKSZjs2BvTq65g
         lrwd5rknV9gx1d5I1hu++icUp3ALAtwXtJXUjAwU=
Date:   Fri, 20 Mar 2020 18:26:28 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, rostedt@goodmis.org, mingo@kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org
Subject: Re: [PATCH 0/4] A bunch of renames
Message-ID: <20200320182627.GA8471@willie-the-truck>
References: <20200320115638.737385408@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320115638.737385408@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 12:56:38PM +0100, Peter Zijlstra wrote:
> While going over a lot of code, we ran into a bunch of confusingly named
> functions. These 4 patches try and fix some of that.

For the lot:

Acked-by: Will Deacon <will@kernel.org>

I hadn't realised quite how confusing these were until I read this series!

Will
