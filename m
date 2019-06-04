Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 506DA33FB9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 09:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfFDHPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 03:15:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49386 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfFDHPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wxPjJbaYKp96HTKmSBj+UfqnDDbX09sXnFXpblHJYc8=; b=eYHsHwJUxI4lp3V1hWKtGDitT
        eyL/eId9Bqkd3A+i5naYrGGMcUN31cGVgyz5qy6JrVrT7BBDeYEAIihhnRAHodcqlj7t52NRfmJ5H
        F9tFAcaarPzm/feLGevCUvBaw96k/dChbOUE/KxfQy5QFwqMPbKz5XYUvt9NLAgbuTquEaj2qS9j8
        xPWwFBAoMtftcDKUKk3XPvGm9JSjI6ltFaB0QjTgzEQ++yeW8Iu59dlism4Jds6T7hbzvQefs/dKx
        60m+ZyQn2lenmL+oL5ZT1wgk2Gd/0Zqq8D0zFgwAN544al8QkT8jXkuu2ea/gpTVbJGPGN+91BkMk
        2aNr+qfLg==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hY3fK-0004E3-Ih; Tue, 04 Jun 2019 07:15:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: x86 fpu cleanups
Date:   Tue,  4 Jun 2019 09:15:21 +0200
Message-Id: <20190604071524.12835-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series finishes off some cleanups that are possible now that
Sebastians fpu rework is finished.
