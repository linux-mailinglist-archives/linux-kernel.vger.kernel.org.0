Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1B07D9BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 22:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394730AbfJPUwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 16:52:10 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58530 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387460AbfJPUwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:52:10 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 9A19820B71C6; Wed, 16 Oct 2019 13:52:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9A19820B71C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1571259129;
        bh=d+Ysm+jyrNC1lniKfbvqDsEbq72HSSw3e1BvBRMGO6w=;
        h=From:To:Cc:Subject:Date:Reply-To:From;
        b=HWdZcriUfiUZvg7neKyFFitW1RWYsRucNa0yUzPfWIJPuODaofcUyWqognnCc8neq
         9j/ZAE2BRNh1WKSsoSps4/W+JN5CLVvNgNg26rQk71x8NDQYe7AEkzt1aZ8VSmULaq
         lQNbLdRfQGlbU7rzTSP7+Z91VCxNeIE4jxdZ/AYs=
From:   longli@linuxonhyperv.com
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [PATCH 0/7] cifs: smbd: Improve reliability on transport reconnect
Date:   Wed, 16 Oct 2019 13:51:49 -0700
Message-Id: <1571259116-102015-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: longli@microsoft.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

Long Li (7):
  cifs: Don't display RDMA transport on reconnect
  cifs: smbd: Invalidate and deregister memory registration on re-send
  cifs: smbd: Return -EINVAL when the number of iovs exceeds
    SMBDIRECT_MAX_SGE
  cifs: smbd: Add messages on RDMA session destroy and reconnection
  cifs: smbd: Return -ECONNABORTED when trasnport is not in connected
    state
  cifs: smbd: Only queue work for error recovery on memory registration
  cifs: smbd: Return -EAGAIN when transport is reconnecting

 fs/cifs/cifs_debug.c |  5 +++++
 fs/cifs/file.c       | 19 +++++++++++++++++--
 fs/cifs/smbdirect.c  | 36 +++++++++++++++++++++---------------
 fs/cifs/transport.c  |  7 +++++--
 4 files changed, 48 insertions(+), 19 deletions(-)

-- 
2.17.1

