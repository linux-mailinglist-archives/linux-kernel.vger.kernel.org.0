Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61518FAABF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 08:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfKMHSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 02:18:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43492 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfKMHSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8rx8VutEKLarfDdcffuS7CQrkd97UyjWpCQO09dbNFA=; b=Hj3II+us8NKtahTNSazTuv8Dy
        X/Yxgho+2eKUJqhrb1TlaXFjaWXTMKdFbJkJu5Gz6peJdXUpuGovQCsf5JlLe+HZVNuk5zUNux57P
        QZioFeCGs/adFv3CoST6M2gS4brpAV90VXxWo3YqorbH2NJxe/RgnCT7lk+wtj9fK7cfJ0/1PmumN
        RVwQTVPWq3C6BCxmnlFMVAV1BeA38tDHZNhLKtq3zIoy/xyTLPoJc+yvEiKY6bNLTrZaskw3H/VL/
        HVU+YJxj08Y64VX7d+DbzGhVPXUqZa8ICZmv3XQKdAmDgubVNQ4J1NQVw0QaTD7yY64AEynZcwxBc
        02WMK1sYA==;
Received: from [2001:4bb8:180:3806:c70:4a89:bc61:5] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUmvG-0008Ah-5M; Wed, 13 Nov 2019 07:18:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Remove the calgary iommu driver
Date:   Wed, 13 Nov 2019 08:18:33 +0100
Message-Id: <20191113071836.21041-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

per the discussion a few month ago with Jon we've agreed that the
calgary iommu driver is obsolete and in the way. Jon said back then
he'd send a patch to remove it, but as that didn't happen I prepared
one, plus two small cleanups touching the same area.
