Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 354FCE6A91
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 02:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfJ1Brp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 21:47:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:5308 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbfJ1Bro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 21:47:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2019 18:47:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,238,1569308400"; 
   d="scan'208";a="224494254"
Received: from rmullina-mobl.amr.corp.intel.com (HELO [10.255.229.12]) ([10.255.229.12])
  by fmsmga004.fm.intel.com with ESMTP; 27 Oct 2019 18:47:42 -0700
Subject: Re: [PATCH] ASoC: SOF: Fix memory leak in sof_dfsentry_write
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20191027194856.4056-1-navid.emamdoost@gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4d08ed12-48fa-ed7f-3988-8d040c64acb1@linux.intel.com>
Date:   Sun, 27 Oct 2019 20:47:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191027194856.4056-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/19 2:48 PM, Navid Emamdoost wrote:
> In the implementation of sof_dfsentry_write() memory allocated for
> string is leaked in case of an error. Go to error handling path if the
> d_name.name is not valid.
> 
> Fixes: 091c12e1f50c ("ASoC: SOF: debug: add new debugfs entries for IPC flood test")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/sof/debug.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
> index 54cd431faab7..5529e8eeca46 100644
> --- a/sound/soc/sof/debug.c
> +++ b/sound/soc/sof/debug.c
> @@ -152,8 +152,10 @@ static ssize_t sof_dfsentry_write(struct file *file, const char __user *buffer,
>   	 */
>   	dentry = file->f_path.dentry;
>   	if (strcmp(dentry->d_name.name, "ipc_flood_count") &&
> -	    strcmp(dentry->d_name.name, "ipc_flood_duration_ms"))
> -		return -EINVAL;
> +	    strcmp(dentry->d_name.name, "ipc_flood_duration_ms")) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
>   
>   	if (!strcmp(dentry->d_name.name, "ipc_flood_duration_ms"))
>   		flood_duration_test = true;
> 
