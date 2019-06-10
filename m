Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 642D33BE47
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 23:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390019AbfFJVU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 17:20:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388642AbfFJVU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Nh/TPzLyd2D7xuO2qHtr/D2CiJIUUJD9lCM4VYzisEs=; b=eAJui6quBB70YSHz33U6dln+E
        5ZopmAmZ0LUX+89O5EWO60T2ed4ZVsO9+7k+C1oNGo6v18/rslKBR+fGndUcfA20GnX55ZajxomKV
        L3Qc9AxWZYWJ98hkQ++0Doii7Ty0vYLZZnHqSV2WTQeAquMEHCw0X1Ng7zAMPlV0RTRpQZx8Re6Ba
        AyFYuVnj8ncqIaT4Kr+tvklVCTVwiqKO3nMS+pO0sC9NV226e85Q6B4SJ/au7wg650MtJTUwsCRkO
        75nr9/ggomY9oNmsoCZCtGk17tfoZWMh8Ji5aaKtZKpE3BiQx80Yj80miXkkPJ3fO1bpaqorfkWQ1
        6aIXL/UOg==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1haRiD-0000JR-Vb; Mon, 10 Jun 2019 21:20:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: binfmt_flat cleanups and RISC-V support
Date:   Mon, 10 Jun 2019 23:20:00 +0200
Message-Id: <20190610212015.9157-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

below is a larger stash of cleanups for the binfmt_misc code,
preparing for the last patch that now trivially adds RISC-V
support, which will be used for the RISC-V nommu series I am
about to post.
