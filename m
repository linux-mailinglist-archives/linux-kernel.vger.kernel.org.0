Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC4DFA6433
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 10:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfICIqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 04:46:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfICIqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b70sepwhN8q1iqLMO3aK0ToUTreTjvrdLY0yLnuLs1s=; b=FJTvHrbiUE5UkVsFYMAHXOD2I
        sCg2YlKoLGXVGsfFYYG0Jn5K9fgTDd4GB7Up7EM82M9wTLdBskzVnHkmVTT7Uv6eyYP8vU2o1lbcK
        BXVE97NOqNi/on8BQTU3FivWew6c9b/vJHjwovZh7U0hMMnweK4r4KbCuFs2MMDx2NEWJ3fPQqyM5
        ac+3uIhJROXdxr2uzo/9G7sdY1R1PVG1AkkVV9tmRtF53BssRlwSdGuheiBXCm7cZKmhgE9eSqz0p
        q5Ss89/LkA6f+pl1QkKmE3dARRBd9dtO1654xqflNqs7M73zhXSZqZ2g4W2D1qcrgcP+CodmHP6CJ
        /82hasdnQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i54SA-0003qm-UH; Tue, 03 Sep 2019 08:46:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: usb dma_mask fixups
Date:   Tue,  3 Sep 2019 10:46:09 +0200
Message-Id: <20190903084615.19161-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

the first patch fixes the ohci-sm501 regression that Guenther reported
due to the platform device dma_mask changes.  The second one ports that
fix to another driver that works the same way.  The rest cleans up
various loose ends left over from the dma related usb changes in the
last two merge windows.
