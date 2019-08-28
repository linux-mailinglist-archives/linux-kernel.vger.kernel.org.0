Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A89C2A0AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 21:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfH1Tmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 15:42:49 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:26526 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726576AbfH1Tms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 15:42:48 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7SJgbgo019182;
        Wed, 28 Aug 2019 19:42:39 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 2uns26uemw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 19:42:39 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id DB2AA8D;
        Wed, 28 Aug 2019 19:42:26 +0000 (UTC)
Received: from swahl-linux (swahl-linux.americas.hpqcorp.net [10.33.153.21])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 7A5494A;
        Wed, 28 Aug 2019 19:42:26 +0000 (UTC)
Date:   Wed, 28 Aug 2019 14:42:26 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     linux-kernel@vger.kernel.org
Cc:     ndesaulniers@google.com, tglx@linutronix.de, steve.wahl@hpe.com,
        russ.anderson@hpe.com, dimitri.sivanich@hpe.com,
        mike.travis@hpe.com
Subject: Purgatory compile flag changes apparently causing Kexec relocation
 overflows
Message-ID: <20190828194226.GA29967@swahl-linux>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-28_10:2019-08-28,2019-08-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=890 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxscore=0 clxscore=1011 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908280191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me on responses to this.

I normally would do more diligence on this, but the timing is such
that I think it's better to get this out sooner.

With the tip of the tree from https://github.com/torvalds/linux.git (a
few days old, most recent commit fetched is
bb7ba8069de933d69cb45dd0a5806b61033796a3), I'm seeing "kexec: Overflow
in relocation type 11 value 0x11fffd000" when I try to load a crash
kernel with kdump. This seems to be caused by commit
059f801a937d164e03b33c1848bb3dca67c0b04, which changed the compiler
flags used to compile purgatory.ro, apparently creating 32 bit
relocations for things that aren't necessarily reachable with a 32 bit
reference.  My guess is this only occurs when the crash kernel is
located outside 32-bit addressable physical space.

I have so far verified that the problem occurs with that commit, and
does not occur with the previous commit.  For this commit, Thomas
Gleixner mentioned a few of the changed flags should have been looked
at twice.  I have not gone so far as to figure out which flags cause
the problem.

The hardware in use is a HPE Superdome Flex with 48 * 32GiB dimms
(total 1536 GiB).

One example of the exact error messages seen:

019-08-28T13:42:39.308110-05:00 uv4test14 kernel: [   45.137743] kexec: Overflow in relocation type 11 value 0x17f7affd000
2019-08-28T13:42:39.308123-05:00 uv4test14 kernel: [   45.137749] kexec-bzImage64: Loading purgatory failed

--> Steve Wahl
--
Steve Wahl,  Hewlett Packard Enterprise
