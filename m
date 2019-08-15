Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBD548E57F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 09:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbfHOH1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 03:27:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39310 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfHOH1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X+X8zwPq8S6+jgiNwNmZZqZ3I4CZ0qtOw1LdSC6GCvo=; b=Z/SaBQ2KGXUwFnDt7b9/Sa4p1
        8E0EexaNqFj9QRIBLRdZMFGuHVnx9sHvKE+fJN6KXSfU7q+k4l3Q2GTVjja4i6jdGxCvR66pEkR31
        487Gvu0pq6WYuhsOZ85Nt4PsrEZ73INHPmg/L/iOeAS5eUT/oF9Lhoorv/siN7rZmvI94qjW9QJns
        rqoo3DVF/2ZwD/3pJ3lbsaGQgyjCmLC24+3y3wriJCKyilAKp4iIHD9cGfLLMUkpsFlucDjFkzHjx
        4GosdAIhIp8DqzRkPZjaq5SI6BXpCWIeEjM6XC3xuOe0l1tBvRGy17UM1hUDT52ifHOS2sXvMXjbw
        4q4M2jStA==;
Received: from [2001:4bb8:18c:28b5:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hyAA5-00010N-ER; Thu, 15 Aug 2019 07:27:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: fix radeon and amdgpu for addressing limited root ports
Date:   Thu, 15 Aug 2019 09:26:59 +0200
Message-Id: <20190815072703.7010-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AMD graphics maintainers,

this series fixes a problem in the radeon driver for systems where the
PCIe root port only supports limited (32-bit) addressing as reported
by Atish.  I then also fixed the same issue in amdgpu as the code was
copy and pasted there, and cleaned up the dma mask setting while
touching that area.
