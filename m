Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF28D476
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 15:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfHNNTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 09:19:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57266 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfHNNTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=C1/PeEnTGIHIIc521BXcKxFh9gVf1brG0rZVLhGsiyk=; b=dHFllC+VPxH91LQuraoRwpLbJ
        DpB7zsbbitXyf2qQUXalO92zwx+TeIEgm4cNdi6RkeeLussboOngBaGVlClUcOesqkNhgEHf/4e7C
        3bTtHOLS4pbzOe0HqpJ/3ZdSA/fc1sh7133fyfFvWfMs6nxlHt/YM0Ek8zkJSsl990Wmw3y+uScRV
        sanKFBsNZ38uvWGHh1sA/SKGp5kkIxcC9JGb+5/J0X2Il7EfxJ5pxaRp9JaQN5DBcaoj7574b+ROR
        JRJpyEU51WtDA2gELy2RyMJKN38Dt0KR5s4VZJwOpTY1r56XbEfc7bfmrij6iMGdW0ps+L0rDpVIN
        7z915J7cA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxtBv-0000yF-Me; Wed, 14 Aug 2019 13:19:51 +0000
Date:   Wed, 14 Aug 2019 06:19:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] usbip: Implement SG support
Message-ID: <20190814131951.GA1437@infradead.org>
References: <20190808155435.10050-1-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808155435.10050-1-suwan.kim027@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, I think my

   "usb: add a HCD_DMA flag instead of guestimating DMA capabilities"

is the proper core fix for what your patch 1 works around, as the USB
core should not assume DMA capabilities based on the presence of a DMA
mask.
