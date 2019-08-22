Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF667990BC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 12:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387587AbfHVK0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 06:26:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55970 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731830AbfHVK0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QvcO34wTkx1q03L8ZPni6sOEYrOLMaZGkJZF5UZr6gI=; b=GdR8bcz0yJhRxdOmDa+FKQqLQ
        xSLhDrFRLg0glWzZ3A2rIoGTK3hMh9Xh4OvDLV4qqp5/DxgC5D8t5iaJ7Kt4qq/9ZVKQs0aTKvrNv
        Y3c1NveVilwwEdARd8m6SKLyg27DupDqqA/73Djn0vBI1v8i0OWOLt8p1zl3efcrsmPBYNikCqwCL
        QO0PoledVbzEJ5SGV+5fXnZC9BhpUDmR1WpobIiWs1IIk9h+r0yBel/muucZWU1CoO1P3+3P3CT2a
        SAjIumfqeZkXGMbtH+feqlTHUTOW6BeqQZF4rErTuvuQESEXlIifl/QFIC1B3yAkUBsyfBruKlbFp
        DW44yPZQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0kIu-0008DK-O5; Thu, 22 Aug 2019 10:26:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C0BB307766;
        Thu, 22 Aug 2019 12:26:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 572D8202D580F; Thu, 22 Aug 2019 12:26:50 +0200 (CEST)
Message-Id: <20190822102306.109718810@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 22 Aug 2019 12:23:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org
Subject: [PATCH 0/5] Further sanitize INTEL_FAM6 naming
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of variation has crept in; time to collapse the lot again.

