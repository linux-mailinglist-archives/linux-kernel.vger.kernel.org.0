Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3460150946
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 16:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgBCPLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 10:11:54 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2360 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728781AbgBCPLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:11:54 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 3C76168F46C989B83057;
        Mon,  3 Feb 2020 15:11:50 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 3 Feb 2020 15:11:50 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 3 Feb 2020
 15:11:49 +0000
Date:   Mon, 3 Feb 2020 15:11:48 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alastair D'Silva <alastair@au1.ibm.com>
CC:     <alastair@d-silva.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Keith Busch" <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Rob Herring" <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        "=?ISO-8859-1?Q?C=E9dric?= Le Goater" <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        "Hari Bathini" <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Greg Kurz" <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v2 22/27] nvdimm/ocxl: Implement the heartbeat command
Message-ID: <20200203151148.00000ae0@Huawei.com>
In-Reply-To: <20191203034655.51561-23-alastair@au1.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
        <20191203034655.51561-23-alastair@au1.ibm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Dec 2019 14:46:50 +1100
Alastair D'Silva <alastair@au1.ibm.com> wrote:

> From: Alastair D'Silva <alastair@d-silva.org>
> 
> The heartbeat admin command is a simple admin command that exercises
> the communication mechanisms within the controller.
> 
> This patch issues a heartbeat command to the card during init to ensure
> we can communicate with the card's crontroller.

controller

> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  drivers/nvdimm/ocxl/scm.c | 43 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/nvdimm/ocxl/scm.c b/drivers/nvdimm/ocxl/scm.c
> index 8a30c887b5ed..e8b34262f397 100644
> --- a/drivers/nvdimm/ocxl/scm.c
> +++ b/drivers/nvdimm/ocxl/scm.c
> @@ -353,6 +353,44 @@ static bool scm_is_usable(const struct scm_data *scm_data)
>  	return true;
>  }
>  
> +/**
> + * scm_heartbeat() - Issue a heartbeat command to the controller
> + * @scm_data: a pointer to the SCM device data
> + * Return: 0 if the controller responded correctly, negative on error
> + */
> +static int scm_heartbeat(struct scm_data *scm_data)
> +{
> +	int rc;
> +
> +	mutex_lock(&scm_data->admin_command.lock);
> +
> +	rc = scm_admin_command_request(scm_data, ADMIN_COMMAND_HEARTBEAT);
> +	if (rc)
> +		goto out;
> +
> +	rc = scm_admin_command_execute(scm_data);
> +	if (rc)
> +		goto out;
> +
> +	rc = scm_admin_command_complete_timeout(scm_data, ADMIN_COMMAND_HEARTBEAT);
> +	if (rc < 0) {
> +		dev_err(&scm_data->dev, "Heartbeat timeout\n");
> +		goto out;
> +	}
> +
> +	rc = scm_admin_response(scm_data);
> +	if (rc < 0)
> +		goto out;
> +	if (rc != STATUS_SUCCESS)
> +		scm_warn_status(scm_data, "Unexpected status from heartbeat", rc);
> +
> +	rc = scm_admin_response_handled(scm_data);
> +
> +out:
> +	mutex_unlock(&scm_data->admin_command.lock);
> +	return rc;
> +}
> +
>  /**
>   * allocate_scm_minor() - Allocate a minor number to use for an SCM device
>   * @scm_data: The SCM device to associate the minor with
> @@ -1508,6 +1546,11 @@ static int scm_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		goto err;
>  	}
>  
> +	if (scm_heartbeat(scm_data)) {
> +		dev_err(&pdev->dev, "SCM Heartbeat failed\n");
> +		goto err;
> +	}
> +
>  	elapsed = 0;
>  	timeout = scm_data->readiness_timeout + scm_data->memory_available_timeout;
>  	while (!scm_is_usable(scm_data)) {


