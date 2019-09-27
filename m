Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 577A8C0E2A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 00:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfI0W4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 18:56:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfI0W4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 18:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fG9b0yxGQ1Jf44QQLYlhMC+VV9IZnJsFIu90T3sE/08=; b=W9ZJOcQwTh/petaSlHNfzP9eS
        +8dDgdeyNHN/rMZOHQ/kaJr11XARIZxGLnocvcaB21kVP79c1tSkI5Jzl9KsZ+e39uhMP3qK+Lgoo
        1E50D0C72toYSOG9e4wlhWM0UZ2mR6EWhr0lGCU+1EKMFYDO0RSObFogrRtbffgklRKMDSpHtpelB
        xufapw0o0UuOrRnuGZBodOtDtfiRWBZZE6FXbS7LICTmVTovzsnzYRu+F+T66yNJCoQClAnAWHSkb
        8urmHHj7En+805r4l4XRJXkmsPAb+Mt4nNxUOC/W/tAsDMHgr5maxcAD0N6P4hkRfJOYR+WPqnpOy
        31boWyePw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDz9w-00072z-OF; Fri, 27 Sep 2019 22:56:20 +0000
Date:   Fri, 27 Sep 2019 15:56:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vincent Chen <vincent.chen@sifive.com>
Cc:     linux-riscv@lists.infradead.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        paul.walmsley@sifive.com
Subject: Re: [PATCH 2/4] rsicv: avoid sending a SIGTRAP to a user thread
 trapped in WARN()
Message-ID: <20190927225620.GA26970@infradead.org>
References: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com>
 <1569199517-5884-3-git-send-email-vincent.chen@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569199517-5884-3-git-send-email-vincent.chen@sifive.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh and s/rsicv/riscv/ in the subject, please.
