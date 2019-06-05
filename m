Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2D6236494
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 21:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfFETXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 15:23:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37962 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfFETXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 15:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tZ9ZadoCz7DSrgUvJ5eeUOdNPpiiRhukmDh9GBYfjTo=; b=QoJj07bKgs+DMmAwe+jfZH52X
        /vWJH+TpDgOVKYxITKHSVtgzOCm1QVOiTfEBFqLlcMyWyYNNvAF5vg1FkSWnmQ1JuhZlfBp3KbOfG
        yz6lxEA73PgiXdIH/4Sw1ZFl/AGe/Woyz5uRPU84eig90+KlHywG8y0iJnj3Ta4PWbP9AGsc4GkMB
        gAqyD4pd8P3W+0VL7rgCNvV0Q4hm9MByQ29UDN86poGQj+T1nZB+G6SDxVDKuedB9WNuO80+MSPki
        AJGIhAK64clKbKlrAiiG3bdQrzL1TR/RCrHlEuJCvgOZjQGzjPkz4kOiT1Orog1xkFO5rXKxbHiTZ
        hIPaRrMKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYbVI-0004jg-Qu; Wed, 05 Jun 2019 19:23:20 +0000
Date:   Wed, 5 Jun 2019 12:23:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk,
        linux-ide@vger.kernel.org
Subject: Re: libata: sysctl knob for enabling tpm/opal at runtime
Message-ID: <20190605192320.GA16831@infradead.org>
References: <1559734587-32596-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559734587-32596-1-git-send-email-info@metux.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 01:36:25PM +0200, Enrico Weigelt, metux IT consult wrote:
> Hello folks,
> 
> 
> here's a patchset that allows enabling libata's tpm features (opal)
> at runtime. Until now we need to boot with special kernel parameter,
> in order to use OPAL - this patch also adds a sysctl knob for that.

Or you can use the block/sed-opal.c code which doesn't require the
tweak, and really is the proper way forward to use OPAL.

> The first patch just introduces a systcl subdir for libata, the
> second one adds the actual knob. I had already sent these patches,
> few weeks ago, along with some general build fixes. The latter
> meanwhile went mainline, but haven't received any comments on
> the two opal related ones yet.

Independent of that new sysctls are deprecated.
