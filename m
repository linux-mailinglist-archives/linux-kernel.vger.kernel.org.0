Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5008DD12
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 20:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfHNSgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 14:36:38 -0400
Received: from mail-a05.ithnet.com ([217.64.83.100]:42786 "EHLO
        mail-a05.ithnet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfHNSgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:36:38 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Aug 2019 14:36:36 EDT
Received: (qmail 8432 invoked by uid 0); 14 Aug 2019 18:29:54 -0000
Received: from skraw.ml@ithnet.com by mail-a05 
 (Processed in 2.051755 secs); 14 Aug 2019 18:29:54 -0000
X-Spam-Status: No, hits=1.5 required=5.0
X-Virus-Status: No
X-ExecutableContent: No
Received: from unknown (HELO ithnet.com) (217.64.64.14)
  by mail-a05.ithnet.com with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 14 Aug 2019 18:29:52 -0000
X-Sender-Authentication: SMTP AUTH verified <skraw.ml@ithnet.com>
Date:   Wed, 14 Aug 2019 20:29:51 +0200
From:   Stephan von Krawczynski <skraw.ml@ithnet.com>
To:     linux-kernel@vger.kernel.org
Subject: VLAN tag stacking with bridge/tap device ?
Message-ID: <20190814202951.20d7dff1@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I try to do a setup with qemu and tap devices attached to bridges where 802.1Q
vlan packets that are tag stacked are running through the tap device/bridge
where the outer tag is stripped. But it seems on the way back out of
qemu/guest and back through the tap and bridge no additional vlan tags are
added back.
The very same setup with only one vlan tag that is stripped and added back
works as expected. Is there something in the tap device or bridge code that
prevents stacking? Can this be done by configuration or by additional coding
in the tap or bridge?

-- 
Regards,
Stephan

PS: please add me as cc in reply
