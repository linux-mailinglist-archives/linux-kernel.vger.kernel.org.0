Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 702EFA3BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 18:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfH3QMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 12:12:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37994 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfH3QMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/Ems5+NJMUxWSrs5tQGH8GZAPOE1hkwEvIaWWxY9zNA=; b=PEDN4ZCP7oVn+maWknVbOFIM/
        MZ8worfWRVsNTy5/Isi3f++qmLJ1NboW7PDVLSArwNqjJCXFrV7b3HhDGq8bekJkdpG/7yG+EQ/DX
        lpHImaSzD1NFAWiHxHagPWGhZuarxlRRjYtNvNt+PD0bqflOkcMAGwhykno1RNujCK/7BZdHSh+02
        iTEHbX40qwGAkt8f2XuXrMlF3e4ReFkAzulstt+GrF6sgjH6ve9EHoPBA66I0/EtQ6mH+tLTYyZcy
        YViGOV0Nu9tJyCPDH5Q36BQg8JZpeV6HsYUjtkRqHD3/7qvTNTglL4c3ndQcOdUNhQkX5/++oy2oz
        CqmJg27Jw==;
Received: from [2001:4bb8:180:3f4c:863:2ead:e9d4:da9f] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3jVv-0000kW-Id; Fri, 30 Aug 2019 16:12:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: ioremap cleanups
Date:   Fri, 30 Aug 2019 18:12:34 +0200
Message-Id: <20190830161237.23033-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

these are three cleanups from my generic ioremap series that needed
a few edits, and which I'd like you to pick up through your respective
arch trees for 5.4 if possible.
