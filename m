Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBD0419604D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 22:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgC0VQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 17:16:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:42862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727611AbgC0VQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 17:16:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 086C2AC53;
        Fri, 27 Mar 2020 21:16:37 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 3/3] bcm2835-defconfig-next-2020-03-27
Date:   Fri, 27 Mar 2020 22:16:32 +0100
Message-Id: <20200327211632.32346-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200327211632.32346-1-nsaenzjulienne@suse.de>
References: <20200327211632.32346-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 8068b7b63583764b46416a62856e42fb1f954ab6:

  Merge tag 'tags/bcm2835-defconfig-next-2020-03-09' into defconfig/next (2020-03-10 11:13:21 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-defconfig-next-2020-03-27

for you to fetch changes up to f06f924a65fb3991614fb23a783d4fef9c8d14ea:

  ARM: bcm2835_defconfig: Enable fixed-regulator (2020-03-27 21:27:47 +0100)

----------------------------------------------------------------
Enables fixed regulator in bcm2835_defconfig

----------------------------------------------------------------
Nicolas Saenz Julienne (1):
      ARM: bcm2835_defconfig: Enable fixed-regulator

 arch/arm/configs/bcm2835_defconfig | 1 +
 1 file changed, 1 insertion(+)
