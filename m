Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3741760AD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 18:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgCBREg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Mar 2020 12:04:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:7633 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgCBREg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:04:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 09:04:35 -0800
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="233232650"
Received: from unknown (HELO localhost) ([10.252.41.44])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 09:04:33 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     =?utf-8?Q?Sini=C5=A1a?= Bandin <sinisa@4net.rs>,
        "Souza\, Jose" <jose.souza@intel.com>
Cc:     airlied@gmail.com, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] Linux 5.6-rc2
In-Reply-To: <a1c918b663805e8213a1229edb87883c@4net.rs>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CAHk-=wgqwiBLGvwTqU2kJEPNmafPpPe_K0XgBU-A58M+mkwpgQ@mail.gmail.com> <99fb887f-4a1b-6c15-64a6-9d089773cdd4@4net.rs> <CAPM=9ty3NuSHBd+StNGxVCE9jkmppQ_VTr+jMRgB07qW3dRwrA@mail.gmail.com> <f9081410ef1135003720fa29d27aa10b9d12d509.camel@intel.com> <a1c918b663805e8213a1229edb87883c@4net.rs>
Date:   Mon, 02 Mar 2020 19:04:31 +0200
Message-ID: <87sgiqpu1s.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Mar 2020, Siniša Bandin <sinisa@4net.rs> wrote:
> Sorry to bother, but still a "no go" in rc4 (at the same time, 5.5.7 
> works OK).
>
> Is there anything else I could do to help fix this?

Please wait for the patch to be actually merged to Linus' tree. I assume
it'll make it to v5.6-rc5.

Thanks,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
