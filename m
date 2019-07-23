Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41D0971BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 17:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbfGWPfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 11:35:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44648 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733212AbfGWPfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=h95vwUAZb17z11iq6MTE7WMBYtBu9s65Dlh5cgJgPUg=; b=ubkCq9dpxj9v7lSz8/AQ/smT2
        34fTGpEBrA8UiKObJOtvXQYgFS5Jlj7AtIcS9PpNJEoTnIB3Dtf7I2h3pX3vebsNbMXYL1JJvMCkQ
        ZOsZLsAa4KxBZxW2ZEjDhZQg7/z3wsZNRg7zw7BsLwrCsM+bgrZ59KYceR6Lp1KUYQKJ5Gn3+gHhh
        zDxYmihcYPDfqsxTP14i+3xl1seXb6EQ5KWCTjNCHsP7RLWug79t1WJi3dIaweAS067ifAyj5JHga
        EUz4tu1Iw3U1BR+kuO3iq1Zfm/cga+KwskIWjkBJsv/625ICZMKSnpaHqvMCGHzQbPHPcOO02M8L1
        PdsrO2O/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hpwol-0005pZ-I4; Tue, 23 Jul 2019 15:35:07 +0000
Date:   Tue, 23 Jul 2019 08:35:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: scsi_debug module panic
Message-ID: <20190723153507.GA18638@infradead.org>
References: <20190722233906.5kkmqjcoapw4ev62@XZHOUW.usersys.redhat.com>
 <cd82bbd5-a8b4-3aa4-e342-ac888273923f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd82bbd5-a8b4-3aa4-e342-ac888273923f@infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 07:37:49PM -0700, Randy Dunlap wrote:
> [add linux-scsi]

Fix:

https://marc.info/?l=linux-scsi&m=156378725427719&w=2
