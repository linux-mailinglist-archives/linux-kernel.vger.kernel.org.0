Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF244AB693
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 13:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392145AbfIFLCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 07:02:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:54512 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731418AbfIFLCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:02:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3A9E9B646;
        Fri,  6 Sep 2019 11:02:12 +0000 (UTC)
Date:   Fri, 6 Sep 2019 13:02:21 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas <trenn@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: /dev/mem and secure boot
Message-ID: <20190906130221.0b47a565@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been bitten recently by mcelog not working on machines started in
secure boot mode. mcelog tries to read DMI information from /dev/mem
and fails to open it.

This made me wonder: if not even root can read /dev/mem (nor, I
suppose, /dev/kmem and /dev/port) in secure boot mode, why are we
creating these device nodes at all in the first place? Can't we detect
that we are in secure boot mode and skip that step, and reap the rewards
(faster boot, lower memory footprint and less confusion)?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
