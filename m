Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05D48187204
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Mar 2020 19:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732282AbgCPSNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 14:13:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:8601 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732187AbgCPSNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:13:43 -0400
IronPort-SDR: D5Yk7VgJ+zalOvQlDjRVBfI4SBNI9Rnn1BE+ZSYaLAy+OIshv0/6iWwkaP9WbsM06YFrGScsPJ
 ZIjSUP5iVBEw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 11:13:43 -0700
IronPort-SDR: y5ecVR2f1WjdtYcqB59h/E9KEYgHax45tposUCaAIyLAzS8sPwh9WGxgOQ67ZsqduhPtpz+ulG
 4L4kemwO24Ww==
X-IronPort-AV: E=Sophos;i="5.70,561,1574150400"; 
   d="scan'208";a="390786716"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.77.132]) ([10.254.77.132])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2020 11:13:42 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH 04/10] x86/resctrl: use container_of() in delayed_work
 handlers
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>
References: <20200214182401.39008-1-james.morse@arm.com>
 <20200214182401.39008-5-james.morse@arm.com>
Message-ID: <070d9148-8166-d2c5-63c0-5f6a0f56b730@intel.com>
Date:   Mon, 16 Mar 2020 11:13:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200214182401.39008-5-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2/14/2020 10:23 AM, James Morse wrote:
> mbm_handle_overflow() and cqm_handle_limbo() are both provided with
> the domain's work_struct when called, but use get_domain_from_cpu()
> to find the domain, along with the appropriate error handling.
> 
> container_of() saves some list walking and bitmap testing, use that
> instead.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thank you

Reinette

