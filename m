Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 884F05275A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 11:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbfFYJAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 05:00:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbfFYJAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:00:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A6E281DEB;
        Tue, 25 Jun 2019 09:00:16 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-116-223.ams2.redhat.com [10.36.116.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 217925D71A;
        Tue, 25 Jun 2019 09:00:10 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Jiri Benc <jbenc@redhat.com>
Subject: ebpf: BPF_ALU32 | BPF_ARSH on BE arches
Date:   Tue, 25 Jun 2019 12:00:10 +0300
Message-ID: <xunyo92mox9h.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 25 Jun 2019 09:00:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Looks like the code:

       ALU_ARSH_X:
               DST = (u64) (u32) ((*(s32 *) &DST) >> SRC);
               CONT;
       ALU_ARSH_K:
               DST = (u64) (u32) ((*(s32 *) &DST) >> IMM);
               CONT;

works incorrectly on BE arches since it must operate on lower
parts of 64bit registers.

See failure of test_verifier test 'arsh32 on imm 2' (#23 on
5.2-rc6).


-- 
WBR,
Yauheni Kaliuta
