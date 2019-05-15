Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9DE1F4E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 14:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfEOM7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 08:59:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59414 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfEOM7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:59:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2CBFC27D87F
Subject: Re: [PATCH v4 1/2] platform/chrome: wilco_ec: Remove 256 byte
 transfers
To:     Nick Crews <ncrews@chromium.org>, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        derat@google.com, dtor@google.com, sjg@chromium.org,
        bartfab@chromium.org, lamzin@google.com, jchwong@google.com
References: <20190508213810.123200-1-ncrews@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <f1c10a12-018a-b711-3211-c2258152688d@collabora.com>
Date:   Wed, 15 May 2019 14:59:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508213810.123200-1-ncrews@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/5/19 23:38, Nick Crews wrote:
> The 0xF6 command, intended to send and receive 256 byte payloads to
> and from the EC, is not needed. The 0xF5 command for 32 byte
> payloads is sufficient. This patch removes support for the 0xF6
> command and 256 byte payloads.
> 
> Signed-off-by: Nick Crews <ncrews@chromium.org>

The following patch is queued to the for-next branch for the autobuilders to
play with, if all goes well I'll add the patch for 5.3 when current merge window
closes.

Thanks,
 Enric
