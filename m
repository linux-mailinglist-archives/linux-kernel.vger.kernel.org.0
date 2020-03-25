Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4DC192A95
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 14:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgCYN6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 09:58:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53422 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgCYN6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AH6Zl8DEoiiplzJR5DrmnfKTXZHiON/ilwkpKb++vRU=; b=a/ozLeCiDQfxqV0zoFTTBvVQ9n
        o2UAd6tNIS81vIVDe25SoIZWKoEw9S0UVLp6nr0Fjxb9wpfrwU3ZLJ3dd6uGW1GNJ+nLUCvz/uD/v
        tZ8SUu+7lIGkOgw//t80uQw+QCCqYlElqLzkrnp/FHrysEibCypfLC5lX7xlhEf/Lrf0ytEUqf7sh
        C7DNmCDHzbPAqhf8ivmr/MQ7ou4dNKG2qpH7QpIME/tc3PlegZEdx9Ja++LEAU8ibTrBs/+QsuJTw
        4Spxe4JPFNMSQErNkm2e8WhUC5ZH60Egl4ie3t9PPu8W+27nj8V6tPdtA3bq+clyixGrKb6UTOSs0
        L8+D9JOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH6Xh-0001Pm-NK; Wed, 25 Mar 2020 13:58:01 +0000
Date:   Wed, 25 Mar 2020 06:58:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Gregory CLEMENT <gregory.clement@free-electrons.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mbus: export mvebu_mbus_{add,del}_window for modules
Message-ID: <20200325135801.GA29951@infradead.org>
References: <20200324190623.26482-1-vadym.kochan@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324190623.26482-1-vadym.kochan@plvision.eu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 09:06:23PM +0200, Vadym Kochan wrote:
> Allow to add/del remap window by external modules at runtime.

Please send this together with your driver submission.
