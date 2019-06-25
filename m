Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67CE05263C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 10:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfFYIPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 04:15:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60246 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbfFYIPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fswQqvuQetufWkfPveAE2qCX9AhSijRSF7A07bRfMgc=; b=jhngtguVQUQtx2aNKqBYQ7UBW
        DunHNcATBrwFfvAMgTJdSWWWPdVk6cCgrOPI5gmI25P/b6prXCHVrqw57wYNq/IMw6kSZlOXISrv4
        +pDIEqy4CdNISmAMVcRYPHrv/OzWEIDZvZJ74E+WzXCzdX3h3DQsi/+knGr3sVXROpwSXc0CgtoYY
        fRsS+uqYOQznrRmpqjAtxOfUKOhJrbdgyLVC4yy7TF/gT+bZY27GXF2EA9mNwRSdA1ImTvUc6uh31
        FuC1z9V/nb248cR3rwCF0+XLyqoF2pn0fnU7V6mDutU3/gnxHZTAWHCACHWVFTGNU6mvvksDnLHoG
        MQxFVvAMw==;
Received: from 213-225-6-159.nat.highway.a1.net ([213.225.6.159] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfgbk-00071p-0n; Tue, 25 Jun 2019 08:15:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Oliver O'Halloran <oohall@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: remove unused powernv code v2
Date:   Tue, 25 Jun 2019 10:15:08 +0200
Message-Id: <20190625081512.16704-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

the powerpc powernv port has a fairly large chunk of code that never
had any upstream user.  We generally strive to not keep dead code
around, and this was affirmed at least years Maintainer summit.

Changes since v1:
 - reword some commit message
