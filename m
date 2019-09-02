Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3022A5CE1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 22:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfIBUIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 16:08:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfIBUIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 16:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bwO6paLntB9VHU+vDBa67wTZajbeuF1FpPf0mZJIk0w=; b=sCslFkJnLr/LX7OsPedVuZai8
        pHXK0ahc+g1X+5fJjkqzYcoaFslGFu7+1+LmmXaIDHDtRtf6Gj2Vt8KQ5v5k0XYm8cNHvz0dMfYnx
        2fMwBcJbPGqLK9komjJUR6BkzWbQaI99xRNswidL1EzoAJNF1Y9cnzdllKG7VFDeHxHKJoPZVsmKK
        nrAQeLriv7uMbQU/FV063KkuJpLwDsZU5JrELh/LqYcF7cZSrZcyTrzRQ8mtWoKM8R3h6sckxdjbT
        szlfuh30LVLphVEPuVFIuD8458lxY75PNFUOyemWFQ9ooL6jW5TOUybShhepI7ZXBCaLwJIkgu7Ne
        8qyzWR1ww==;
Received: from [2001:4bb8:18c:1755:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4scD-0007MG-4R; Mon, 02 Sep 2019 20:07:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Loic Pallardy <loic.pallardy@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: remove various dma_declare_coherent related exports
Date:   Mon,  2 Sep 2019 22:07:42 +0200
Message-Id: <20190902200746.16185-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this is a refresh of and older series that tries to ensure that
drivers don't use the dma_declare_coherent function, which is
intende for platform code.  Unfortunately we've actually grown
a user in remoteproc since then.  While the maintainers havee
promised to fix that up that hasn't happened so far, so for now
this disabled the modular build for remoteproc until that has been
solved.
