Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 295CEA1BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2019 15:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfH2Nmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 09:42:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33388 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfH2Nms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:42:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 41E8628D4D8
Subject: Re: [PATCH v4] platform/chrome: cros_ec_trace: update generating
 script
To:     Tzung-Bi Shih <tzungbi@google.com>,
        Raul Rangel <rrangel@chromium.org>
Cc:     bleung@chromium.org, groeck@chromium.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Dylan Reid <dgreid@google.com>
References: <20190730134704.44515-1-tzungbi@google.com>
 <CA+Px+wXetT1mQZW+3zc2vNDP4Jf3zKqGNz=Hq0yHn0Fvf=y-FQ@mail.gmail.com>
 <106711f8-117a-d0df-9b66-dc6be6431d07@collabora.com>
 <CA+Px+wU=V0cGZeAxoqSJeVTLcO+v9=tPQKxKBTp-npsgqXo3yQ@mail.gmail.com>
 <89aac768-b096-c51c-2ec7-5c135b089a31@collabora.com>
 <20190801145050.GA154523@google.com>
 <CA+Px+wUzyFB6vRM91PTFkY_fBfp2xybegy34rbW_D9zzNX6-8Q@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <a75bd837-6b24-6a64-00d8-0b3fe9d5a784@collabora.com>
Date:   Thu, 29 Aug 2019 15:42:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CA+Px+wUzyFB6vRM91PTFkY_fBfp2xybegy34rbW_D9zzNX6-8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tzung-Bi,

On 29/8/19 6:19, Tzung-Bi Shih wrote:
> Hi Enric and Raul,
> 
> Do you have any further concerns on this patch?

This patch will conflict with [2] which hopefully will be merged on next merge
window through Lee's tree. As this patch is only changing the doc I'm willing to
wait after [2] lands. It's on my radar and don't need to resend, I'll do the
required changes.

Best Regards,
 Enric
