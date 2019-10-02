Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6DDC8E18
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 18:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfJBQR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 12:17:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:39677 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfJBQRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 12:17:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 09:17:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,249,1566889200"; 
   d="scan'208";a="196046591"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga006.jf.intel.com with ESMTP; 02 Oct 2019 09:17:24 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 77F42301A2F; Wed,  2 Oct 2019 09:17:24 -0700 (PDT)
Date:   Wed, 2 Oct 2019 09:17:24 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [RFC][PATCH] sysctl: Remove the sysctl system call
Message-ID: <20191002161724.GI8560@tassilo.jf.intel.com>
References: <8736gcjosv.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736gcjosv.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


There were some really old glibc versions that used the system call,
but I believe they have a reasonable fall back, and may not be used
much anymore.

Acked-by: Andi Kleen <ak@linux.intel.com>

-Andi
