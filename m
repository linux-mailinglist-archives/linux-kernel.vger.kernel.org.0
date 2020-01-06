Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0A421317FC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 19:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgAFS62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 13:58:28 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35892 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAFS61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 13:58:27 -0500
Received: from localhost (unknown [IPv6:2610:98:8005::147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1EA22291166;
        Mon,  6 Jan 2020 18:58:26 +0000 (GMT)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, lduncan@suse.com, cleech@redhat.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        open-iscsi@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 0/3] drivers base: transport component error propagation
Date:   Mon,  6 Jan 2020 13:58:14 -0500
Message-Id: <20200106185817.640331-1-krisman@collabora.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This small series improves error propagation on the transport component
to prevent an inconsistent state in the iscsi module.  The bug that
motivated this patch results in a hanging iscsi connection that cannot
be used or removed by userspace, since the session is in an inconsistent
state.

That said, I tested it using the TCP iscsi transport (and forcing errors
on the triggered function), which doesn't require a particularly complex
container structure, so it is not the best test for finding corner cases
on the atomic attribute_container_device trigger version.

Please let me know what you think.

Gabriel Krisman Bertazi (3):
  drivers: base: Support atomic version of
    attribute_container_device_trigger
  drivers: base: Propagate errors through the transport component
  iscsi: Fail session and connection on transport registration failure

 drivers/base/attribute_container.c  | 103 ++++++++++++++++++++++++++++
 drivers/base/transport_class.c      |  11 ++-
 drivers/scsi/scsi_transport_iscsi.c |  18 ++++-
 include/linux/attribute_container.h |   7 ++
 include/linux/transport_class.h     |   6 +-
 5 files changed, 137 insertions(+), 8 deletions(-)

-- 
2.24.1

